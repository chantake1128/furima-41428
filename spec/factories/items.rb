FactoryBot.define do
  factory :item do
    image         { Faker::LoremPixel.image } # ここでFakerを使用してランダムな画像URLを生成
    name          { Faker::Commerce.product_name }
    info          { Faker::Lorem.sentence }
    category_id   { rand(2..11) } 
    status_id     { rand(2..7) }  
    cost_id       { rand(2..4) }  
    prefecture_id { rand(2..48) } 
    day_id        { rand(2..4) }  
    price         { rand(300..9_999_999) }
  end
end
