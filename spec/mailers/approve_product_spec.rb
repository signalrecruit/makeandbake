require "rails_helper"

RSpec.describe ApproveProduct, type: :mailer do
  describe "product_approval" do
    let(:mail) { ApproveProduct.product_approval }

    it "renders the headers" do
      expect(mail.subject).to eq("Product approval")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
