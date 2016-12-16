require 'rails_helper'

RSpec.describe Identity, type: :model do
  before { @identity = FactoryGirl.build :identity }

  subject { @identity }

  # response specs
  it { should respond_to :uid }
  it { should respond_to :provider }
  it { should respond_to :user_id }

  # validation specs
  it { should validate_presence_of :uid }
  it { should validate_presence_of :provider }

  # association spec 
  it { should belong_to :user }

  it { should be_valid }
end
