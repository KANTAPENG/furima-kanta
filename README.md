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
| full_name          | string | null: false |
| full_name_kana     | string | null: false |
| birthday           | string | null: false |

has_one :item
has_one :Shopping Records
has_one :Shopping informations



## items テーブル
| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| item_images        | string | null: false |
| item_name          | string | null: false |
| item_information   | text   | null: false |
| item_type          | string | null: false |
| item_condition     | string | null: false |
| shipping_cost      | string | null: false |
| area_of_origin     | string | null: false |
| days_to_ship       | string | null: false |
| price              | string | null: false |

belongs_to :users


## Shopping Records テーブル
| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| credit_card        | string | null: false |
| effective_date     | string | null: false |
| security_code      | string | null: false |

belongs_to :users
belongs_to :Shopping informations


## Shopping informations テーブル
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