require 'rails_helper'

RSpec.describe Product, type: :model do
  before { @product = FactoryGirl.build :product }

  subject { @product }

  @product_attributes = [:name, :description, :price ]

  @product_attributes.each do |attribute|
  	it { should respond_to attribute }
  end

  @product_attributes.each do |attribute|
    it {should validate_presence_of attribute }
  end

  it { should have_many :attachments }
  it { should belong_to :user }


  describe "test association" do
  	before do 
      @product.save
  	  attachments = 5.times { FactoryGirl.create :attachment, product: @product }
  	end

  	it "raise error for dependent destroy" do 
      attachments = @product.attachments

      @product.destroy

      attachments.each do |attachment|
        expect(Attachment.find(attachment)).to raise_error ActiveRecord::RecordNotFound
      end
  	end
  end
end
