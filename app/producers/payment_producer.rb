class PaymentProducer
  def self.call(payment)
    Hutch.connect
    Hutch.publish('payment.response', subject: payment)
  end
end
