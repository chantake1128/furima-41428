FactoryBot.define do
  factory :item do
    name          { Faker::Commerce.product_name }
    info          { Faker::Lorem.sentence }
    category_id   { rand(2..11) } 
    status_id     { rand(2..7) }  
    cost_id       { rand(2..4) }  
    prefecture_id { rand(2..48) } 
    day_id        { rand(2..4) }  
    price         { rand(300..9_999_999) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/image-generation-ai.jpg'), filename: 'image-generation-ai.jpg')
    end
    
  end
end
