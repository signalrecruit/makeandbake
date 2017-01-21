require "rails_helper"

RSpec.describe DisapproveShop, type: :mailer do
  describe "shop_disapproval" do
    let(:mail) { DisapproveShop.shop_disapproval }

    it "renders the headers" do
      expect(mail.subject).to eq("Shop disapproval")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
