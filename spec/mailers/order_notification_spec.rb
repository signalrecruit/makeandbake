require "rails_helper"

RSpec.describe OrderNotification, type: :mailer do
  describe "notification_of_order" do
    let(:mail) { OrderNotification.notification_of_order }

    it "renders the headers" do
      expect(mail.subject).to eq("Notification of order")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
