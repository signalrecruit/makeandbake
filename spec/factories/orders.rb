FactoryGirl.define do
  factory :order do
    name "MyString"
    email "MyString"
    phonenumber "MyString"
    location "MyString"
    description "MyText"
    order_type "MyString"
    min_price "9.99"
    max_price "9.99"
    size "MyString"
    delivery "2016-12-22 22:47:43"
    recipient_address "MyString"
    recipient_name "MyString"
    recipient_phonenumber "MyString"
    recipient_email "MyString"
    sample_picture "MyString"
    user nil
  end
end
