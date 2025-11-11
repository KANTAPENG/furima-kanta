class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :move_to_root

  def index
    @shopping_record_form = ShoppingRecordForm.new
  end

  def create
    @shopping_record_form = ShoppingRecordForm.new(order_params)
    @shopping_record_form.user_id = current_user.id
    @shopping_record_form.item_id = @item.id

    unless params[:token].present?
      flash.now[:alert] = "カード情報が正しく送信されていません"
      render :index, status: :unprocessable_entity and return
    end

    if @shopping_record_form.valid?
      begin
        Payjp.api_key = ENV['PAYJP_SECRET_KEY'] 
        charge = Payjp::Charge.create(
          amount: @item.price,        
          card: params[:token],      
          currency: 'jpy'
        )
      rescue Payjp::PayjpError => e
        logger.error "PAY.JP charge failed: #{e.class} #{e.message}"
        flash.now[:alert] = "決済に失敗しました: #{e.message}"
        render :index, status: :unprocessable_entity and return
      end
      @shopping_record_form.save
      redirect_to root_path, notice: "購入が完了しました"
    else
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
end