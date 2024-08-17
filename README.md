<!--ユーザー-->
## users

| Column             | Type                | Options                        |
|--------------------|---------------------|--------------------------------|
| nickname           | string              | null: false                    |
| email              | string              | null: false, unique: true      |
| encrypted          | string              | null: false                    |
| last_name          | string              | null: false                    |
| fast_name          | string              | null: false                    |
| last_name_kana     | string              | null: false                    |
| fast_name_kana     | string              | null: false                    |
| birth_year         | string              | null: false                    |
| birth_month        | string              | null: false                    |
| birth_day          | string              | null: false                    |

### Association
- has_many :items
- has_many :orders

<!--商品情報-->
## items

| Column             | Type                | Options                        |
|--------------------|---------------------|--------------------------------|
| name               | string              | null: false                    |
| info               | string              | null: false                    |
| category           | string              | null: false                    |
| status             | string              | null: false                    |
| cost               | string              | null: false                    |
| area               | string              | null: false                    |
| days               | string              | null: false                    |
| price              | string              | null: false                    |
| user               | references          | null: false, foreign_key:true  |

### Association
- belongs_to :users
- has_one    :orders

<!--購入記録-->
## orders

| Column             | Type                | Options                        |
|--------------------|---------------------|--------------------------------|
| user               | references          | null: false, foreign_key:true  |
| item               | references          | null: false, foreign_key:true  |

### Association
- belongs_to :users
- belongs_to :items
- has_one    :deliverys

<!--発送先情報-->
## deliverys

| Column             | Type                | Options                        |
|--------------------|---------------------|--------------------------------|
| postal_code        | string              | null: false                    |
| prefecture         | string              | null: false                    |
| city               | string              | null: false                    |
| street_adress      | stirng              | null: false                    |
| building_name      | string              |                                |
| phone_number       | string              | null: false                    |
| order              | references          | null: false, foreign_key:true  |

### Association
belong_to :orders
