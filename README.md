# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## users テーブル
| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| first_name         | string | null: false |
| last_name          | string | null: false |
| first_name_kana    | string | null: false |
| last_name_kana     | string | null: false |
| birthday           | date   | null: false |

has_many :item
has_many :shopping records



## items テーブル
| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| item_images        | string | null: false |
| item_name          | string | null: false |
| item_information   | text   | null: false |
| item_type_id       | integer | null: false |
| item_condition_id  | integer | null: false |
| shipping_cost_id   | integer | null: false |
| area_of_origin_id  | integer | null: false |
| days_to_ship_id    | integer | null: false |
| price_id           | integer | null: false |
| user               | references | null: false, foreign_key: true |

belongs_to :user


## shopping Records テーブル
| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| credit_card        | string | null: false |
| effective_date     | string | null: false |
| security_code      | string | null: false |
| user               | references | null: false, foreign_key: true |
| item               | references | null: false, foreign_key: true |

belongs_to :users
belongs_to :Shopping informations


## shopping informations テーブル
| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| postal_code        | string | null: false |
| prefectures        | string | null: false |
| municipalities     | string | null: false |
| street_address     | string | null: false |
| building_name      | string | null: false |
| phone_number       | string | null: false |

has_one :Shopping Records
belongs_to :users