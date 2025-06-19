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

has_many :items
has_many :shopping_records



## items テーブル
| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| item_name          | string | null: false |
| item_information   | text   | null: false |
| item_type_id       | integer | null: false |
| item_condition_id  | integer | null: false |
| shipping_cost_id   | integer | null: false |
| area_of_origin_id  | integer | null: false |
| days_to_ship_id    | integer | null: false |
| price              | integer | null: false |
| user               | references | null: false, foreign_key: true |

belongs_to :user
has_one :shopping_record


## shopping_records テーブル
| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| user               | references | null: false, foreign_key: true |
| item               | references | null: false, foreign_key: true |

belongs_to :user
has_one :shopping_information
belongs_to :item


## shopping_informations テーブル
| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| postal_code        | string | null: false |
| prefectures_id     | integer | null: false |
| municipality       | string | null: false |
| street_address     | string | null: false |
| building_name      | string |             |
| phone_number       | string | null: false |
| shopping_record    | references | null: false, foreign_key: true |

belongs_to :shopping_record