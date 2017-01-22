require "rails_helper"

RSpec.describe NotifyAdminOfShopCreation, type: :mailer do
  describe "admin_notification" do
    let(:mail) { NotifyAdminOfShopCreation.admin_notification }

    it "renders the headers" do
      expect(mail.subject).to eq("Admin notification")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
