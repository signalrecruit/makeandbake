require "rails_helper"

RSpec.describe ApproveShop, type: :mailer do
  describe "shop_approval" do
    let(:mail) { ApproveShop.shop_approval }

    it "renders the headers" do
      expect(mail.subject).to eq("Shop approval")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
