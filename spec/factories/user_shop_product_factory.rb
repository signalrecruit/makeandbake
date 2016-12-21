FactoryGirl.define do
  PROFILE_PIC ||= File.open(Rails.root.join('spec/fixtures/profile_pic.jpg'))
  IMAGE_ONE ||= File.open(Rails.root.join("spec/fixtures/cake1.jpg"))
  IMAGE_TWO ||= File.open(Rails.root.join("spec/fixtures/cake2.jpg"))
  IMAGE_THREE ||= File.open(Rails.root.join("spec/fixtures/cake3.jpg"))
  IMAGE_FOUR ||= File.open(Rails.root.join("spec/fixtures/cake4.jpg"))
  SHOP_BANNER ||= File.open(Rails.root.join("spec/fixtures/shop_banner.jpg"))

  


  factory :tag do
    category_list = ["birthday", "anniversary", "party", "celebration", "New Year", "Christmas", "wedding anniversary", 
      "wedding cake"]
    name { category_list[rand(0..6)] }
    # product
  end


  factory :product do
    product_list = ["chocolate cake", "vanilla cake", "strawberry cake", "plain cake"]
    size = ["small", "medium", "large"]
    name { product_list[rand(0..3)] }
    description "some random description"
    price { rand(1..500).to_f }
    size { size[rand(0..2)] }
    imageone IMAGE_ONE
    imagetwo IMAGE_TWO
    imagethree IMAGE_THREE
    imagefour IMAGE_FOUR
    user


    factory :product_with_tags do
      transient do 
        tags_count 2
      end 

      after(:create) do |product, evaluator|
        create_list(:tag, evaluator.tags_count, products: [product])
      end
    end
  end





  factory :shop do 
    city_list = ["accra", "kumasi", "east legon", "madina", "circle"]
    name { FFaker::Company.name }
    description { FFaker::Lorem.paragraph }
    location { city_list[rand(0..4)] }
    opening { DateTime.now }
    closing {DateTime.now + 6.hours }
    image SHOP_BANNER
    user 

    factory :shop_with_products do 
      transient do
        products_count 10 
      end

      after(:create) do |shop, evaluator|
        create_list(:product, evaluator.products_count, shop: shop)
      end
    end
  end










  factory :user do
  	email { FFaker::Internet.email }
  	password "password"
  	password_confirmation "password"
  	username { FFaker::Name.first_name}
    fullname { FFaker::Name.name }
  	first_name { FFaker::Name.first_name }
  	last_name { FFaker::Name.last_name } 
    phonenumber "0204704427"
    image PROFILE_PIC


  	trait :admin do 
      admin true
    end   

    trait :seller do
      seller true
    end

    trait :sex do 
      sex 'female'
    end



    factory :user_with_shops do 
      transient do 
        shops_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:shop, evaluator.shops_count, user: user )
      end

      factory :user_with_products do 
        transient do 
          products_count 10
        end

        after(:create) do |user, evaluator|
          create_list(:product, evaluator.products_count, user: user)
        end
      end

    end
  end
end
