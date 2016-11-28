require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryGirl.build :user }

  subject { @user }

  @user_attributes = [:email, :password, :password_confirmation, :first_name, :last_name, :username, :age, :admin, :seller]

  it { should be_valid }

  #response to user attributes

  @user_attributes.each do |attribute|
  	it { should respond_to attribute}
  end
  
  @validated_attributes = [:email, :first_name, :last_name, :age]

  @validated_attributes.each do |attribute|
    it { should validate_presence_of attribute }
  end
end
