require "rails_helper"

RSpec.describe DisapproveProduct, type: :mailer do
  describe "product_disapproval" do
    let(:mail) { DisapproveProduct.product_disapproval }

    it "renders the headers" do
      expect(mail.subject).to eq("Product disapproval")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
