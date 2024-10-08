<!--ユーザー-->
## usersテーブル

| Column             | Type                | Options                        |
|--------------------|---------------------|--------------------------------|
| nickname           | string              | null: false                    |
| email              | string              | null: false, unique: true      |
| encrypted_password | string              | null: false                    |
| last_name          | string              | null: false                    |
| first_name         | string              | null: false                    |
| last_name_kana     | string              | null: false                    |
| first_name_kana    | string              | null: false                    |
| birth_day          | date                | null: false                    |


### Association
- has_many :items
- has_many :orders

<!--商品情報-->
## itemsテーブル
<!--商品の状態, 配送料の負担, 発送元の地域,発送までの日数,カテゴリーのカラムはActiveHashを使用します-->

| Column             | Type                | Options                        |
|--------------------|---------------------|--------------------------------|
| name               | string              | null: false                    |
| info               | text                | null: false                    |
| category_id        | integer             | null: false                    |
| status_id          | integer             | null: false                    |
| cost_id            | integer             | null: false                    |
| prefecture_id      | integer             | null: false                    |
| day_id             | integer             | null: false                    |
| price              | integer             | null: false                    |
| user               | references          | null: false, foreign_key:true  |

### Association

  # ActiveHashの関連付け
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :cost
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :day

  # 他の関連付け
- belongs_to :user
- has_one    :order

<!--購入記録-->
## ordersテーブル

| Column             | Type                | Options                        |
|--------------------|---------------------|--------------------------------|
| user               | references          | null: false, foreign_key:true  |
| item               | references          | null: false, foreign_key:true  |

### Association
- belongs_to :user
- belongs_to :item
- has_one    :delivery

<!--発送先情報-->
## deliverysテーブル

| Column             | Type                | Options                        |
|--------------------|---------------------|--------------------------------|
| postal_code        | string              | null: false                    |
| prefecture_id      | integer             | null: false                    |
| city               | string              | null: false                    |
| street_address     | string              | null: false                    |
| building_name      | string              |                                |
| phone_number       | string              | null: false                    |
| order              | references          | null: false, foreign_key: true |

### Association

  # ActiveHashの関連付け
  belongs_to_active_hash :prefecture

  # 他の関連付け
  belongs_to :order
