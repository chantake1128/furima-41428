<!--ユーザー-->
## usersテーブル

| Column             | Type                | Options                        |
|--------------------|---------------------|--------------------------------|
| nickname           | string              | null: false                    |
| email              | string              | null: false, unique: true      |
| encrypted          | string              | null: false                    |
| last_name          | string              | null: false                    |
| fast_name          | string              | null: false                    |
| last_name_kana     | string              | null: false                    |
| fast_name_kana     | string              | null: false                    |
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
| category_id        | integer             | null: false, foreign_key: true |
| status_id          | integer             | null: false, foreign_key: true |
| cost_id            | integer             | null: false, foreign_key: true |
| area_id            | integer             | null: false, foreign_key: true |
| days_id            | integer             | null: false, foreign_key: true |
| price              | string              | null: false                    |
| user_id            | references          | null: false, foreign_key:true  |

### Association

  # ActiveHashの関連付け
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :cost
  belongs_to_active_hash :area
  belongs_to_active_hash :days

  # 他の関連付け
- belongs_to :user
- has_one    :order

<!--購入記録-->
## ordersテーブル

| Column             | Type                | Options                        |
|--------------------|---------------------|--------------------------------|
| user_id            | references          | null: false, foreign_key:true  |
| item_id            | references          | null: false, foreign_key:true  |

### Association
- belongs_to :user
- belongs_to :item
- has_one    :delivery

<!--発送先情報-->
## deliverysテーブル

| Column             | Type                | Options                        |
|--------------------|---------------------|--------------------------------|
| postal_code        | string              | null: false                    |
| prefecture         | string              | null: false                    |
| city               | string              | null: false                    |
| street_adress      | stirng              | null: false                    |
| building_name      | string              |                                |
| phone_number       | string              | null: false                    |
| order_id           | references          | null: false, foreign_key:true  |

### Association
belong_to :order
