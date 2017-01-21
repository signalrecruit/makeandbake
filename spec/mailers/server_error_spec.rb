require "rails_helper"

RSpec.describe ServerError, type: :mailer do
  describe "server_error_notifier" do
    let(:mail) { ServerError.server_error_notifier }

    it "renders the headers" do
      expect(mail.subject).to eq("Server error notifier")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
