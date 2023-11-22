## usersテーブル
| Column                | Type              | Option                         |
| --------------------- | ----------------- | ------------------------------ |
| nickname              | string            | null: false                    |
| email                 | string            | null: false, unique: true      |
| encrypted_password    | string            | null: false                    |
| last_name_full        | string            | null: false                    |
| first_name_full       | string            | null: false                    |
| last_name_kana        | string            | null: false                    |
| first_name_kana       | string            | null: false                    |
| birthday              | date              | null: false                    |

### Association
- has_many :items
- has_many :purchases


## itemsテーブル
| Column                | Type              | Option                         |
| --------------------- | ----------------- | ------------------------------ |
| product_name          | string            | null: false                    |
| explanation           | text              | null: false                    |
| category_id           | integer           | null: false                    |
| conditiion_id         | integer           | null: false                    |
| shipping_charge_id    | integer           | null: false                    |
| prefecture_id         | integer           | null: false                    |
| shipping_date_id      | integer           | null: false                    |
| price                 | integer           | null: false                    |
| user                  | references        | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase


## addressesテーブル
| Column                | Type              | Option                         |
| --------------------- | ----------------- | ------------------------------ |
| post_code             | string            | null: false                    |
| prefecture_id         | integer           | null: false                    |
| city_id               | string            | null: false                    |
| house_number          | string            | null: false                    |
| building              | string            |                                |
| phone_number          | string            | null: false                    |
| purchase              | references        | null: false, foreign_key: true |

### Association
- belongs_to :purchase


## purchasesテーブル
| Column                | Type              | Option                         |
| --------------------- | ----------------- | ------------------------------ |
| user                  | references        | null: false, foreign_key: true |
| item                  | references        | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :address
- belongs_to :item



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
