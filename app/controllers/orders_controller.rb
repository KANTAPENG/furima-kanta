class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :move_to_root

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @shopping_record_form = ShoppingRecordForm.new
  end

  def create
    @order_form = ShoppingRecordForm.new(order_params)
    if @order_form.valid?
      pay_item 
      @order_form.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_root
    if current_user.id == @item.user_id || @item.shopping_record.present?
      redirect_to root_path
    end
  end

  def order_params
  params.require(:shopping_record_form)
        .permit(:postal_code, :prefecture_id, :municipality, :street_address, :building_name, :phone_number)
        .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end
  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
  )
  rescue Payjp::PayjpError => e
    logger.error "PAY.JP charge failed: #{e.class} #{e.message}"
    flash.now[:alert] = "決済に失敗しました: #{e.message}"
    render :index, status: :unprocessable_entity and return
  end
end