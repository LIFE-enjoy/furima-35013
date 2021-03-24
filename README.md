## users table

| Column               | Type   | Options                   |
| -------------------- | ------ | ------------------------- |
| nickname             | string | null: false, unique: true |
| email                | string | null: false, unique: true |
| password             | string | null: false, unique: true |
| last_name            | string | null: false               |
| first_name           | string | null: false               |
| last_name_kana       | string | null: false               |
| first_name_kana      | string | null: false               |
| birth_year           | integer| null: false               |
| birth_month          | integer| null: false               |
| birth_day            | integer| null: false               |

### Association
- has_many :items
- has_many :orders

## items table

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| item_image          |            | null: false, ActiveStorage     |
| item_name           | string     | null: false                    |
| info                | text       | null: false                    |
| category            | integer    | null: false, ActiveHash        |
| status              | integer    | null: false, ActiveHash        |
| shipping_cost       | integer    | null: false, ActiveHash        |
| shipping_area       | integer    | null: false, ActiveHash        |
| ship_date           | integer    | null: false, ActiveHash        |
| price               | string     | null: false, ActiveHash        |
| user                | references | null: false, foreign_key: true |

### Association
- has_one :order
- belongs_to :user
- has_one :order_record
- has_many :comments

## orders table

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| postal_code         | string     | null: false                    |
| prefecture          | integer    | null: false, ActiveHash        |
| city                | string     | null: false                    |
| address             | string     | null: false                    |
| building            | string     | null: false                    |
| phone_number        | integer    | null: false                    |
| user                | references | null: false, foreign_key: true |

### Association
- belongs_to :item
- belongs_to :user

## order_records table
| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| item                | references | null: false, foreign_key: true |

### Association
- belongs_to :item


## comment table

| Column              | Type       | Options                        |
| ------------------- | ------     | ------------------------------ |
| comment             | text       | null: false                    |
| user                | references | null: false, foreign_key: true |
| item                | references | null: false, foreign_key: true |

### Association
-belongs_to :item


