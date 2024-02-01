module PaymentEnumetations
  extend Enumerize

  enumerize :status, in: [
    :pending,
    :pre_authorized,
    :authorized,
    :failed,
    :canceled,
    :voided,
    :refund_pending,
    :charged_back
  ]

  enumerize :payment_type, in: [
    :credit,
    :debit,
    :pix,
    :bank_slip
  ]

  enumerize :source_type, in: [
    :card,
    :token
  ]
end
