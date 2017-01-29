require "rails_helper"

RSpec.describe NotifySeller, type: :mailer do
  describe "seller_notification" do
    let(:mail) { NotifySeller.seller_notification }

    it "renders the headers" do
      expect(mail.subject).to eq("Seller notification")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
