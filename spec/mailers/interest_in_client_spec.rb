require "rails_helper"

RSpec.describe InterestInClient, type: :mailer do
  describe "establish_interest" do
    let(:mail) { InterestInClient.establish_interest }

    it "renders the headers" do
      expect(mail.subject).to eq("Establish interest")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
