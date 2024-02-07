require 'rails_helper'

describe PaymentProducer do
  describe "#self.call" do
    it "Publiches a message with hutch" do
      allow(Hutch).to receive(:connect).and_return(true)
      allow(Hutch).to receive(:publish).with('payment.response', subject: 123).and_return(true)

      PaymentProducer.call(123)

      expect(Hutch).to have_received(:publish).with('payment.response', subject: 123)
    end
  end
end
