FactoryGirl.define do
  factory :user do
  	email { FFaker::Internet.email }
  	password "123456789"
  	password_confirmation "123456789"
  	username { FFaker::Name.first_name}
  	first_name { FFaker::Name.first_name }
  	last_name { FFaker::Name.last_name } 

  	trait :admin do 
      admin true
    end   

    trait :seller do
      seller true
    end

    trait :sex do 
      sex 'female'
    end
  end
end
