require 'rails_helper'

RSpec.describe Search, type: :model do
  before { @search = FactoryGirl.build :search }

  subject { @search }

  it { should be_valid }

  # test validation
  @search_attributes = [:keywords, :name, :min_price, :max_price]

  @search_attributes.each do |attribute|
  	it { should respond_to attribute }
  end
end
