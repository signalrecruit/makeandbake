FactoryGirl.define do
  factory :tag do
    name "Category"
    # product
  end

  factory :product do
  	product_list = ["chocolate cake", "vanilla cake", "strawberry cake", "plain cake"]
    name { product_list[rand(1..3)] }
    description "some random description"
    price { rand(1..500).to_f }
    user

    factory :product_with_tags do
      transient do 
      	tags_count 5
      end 

      after(:create) do |product, evaluator|
        create_list(:tag, evaluator.tags_count, products: [product])
      end
    end
  end
end
