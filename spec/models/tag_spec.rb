require 'rails_helper'

RSpec.describe Tag, type: :model do
  before { @tag = FactoryGirl.build :tag }

  subject { @tag }
  
  it { should respond_to :name }
  it { should validate_presence_of :name }
  it { should have_and_belong_to_many :products }

  it { should be_valid }
end
