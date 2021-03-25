## users table

| Column               | Type   | Options                   |
| -------------------- | ------ | ------------------------- |
| nickname             | string | null: false, unique: true |
| email                | string | null: false, unique: true |
| encrypted_password   | string | null: false               |
| last_name            | string | null: false               |
| first_name           | string | null: false               |
| last_name_kana       | string | null: false               |
| first_name_kana      | string | null: false               |
| birth_date           | date   | null: false               |

### Association
- has_many :items
- has_many :order_records

## items table

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| item_name           | string     | null: false                    |
| info                | text       | null: false                    |
| category_id         | integer    | null: false, ActiveHash        |
| status_id           | integer    | null: false, ActiveHash        |
| shipping_cost_id    | integer    | null: false, ActiveHash        |
| prefecture_id       | integer    | null: false, ActiveHash        |
| ship_date_id        | integer    | null: false, ActiveHash        |
| price               | integer    | null: false                    |
| user                | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :order_record

## orders table

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| postal_code         | string     | null: false                    |
| prefecture_id       | integer    | null: false, ActiveHash        |
| city                | string     | null: false                    |
| address             | string     | null: false                    |
| building            | string     |                                |
| phone_number        | integer    | null: false                    |
| order_record        | references | null: false, foreign_key: true |

### Association
- has_one :order_record

## order_records table
| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| item                | references | null: false, foreign_key: true |
| user                | references | null: false, foreign_key: true |

### Association
- belongs_to :order
- belongs_to :user
- belongs_to :item
