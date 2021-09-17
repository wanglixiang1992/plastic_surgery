# frozen_string_literal: true

class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :line_items, dependent: :destroy

  validates :invoice_date, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0.00 }

  after_commit :generate_qbo_invoice, on: :create

  def generate_qbo_invoice
    QuickbooksSyncService.new.sync_invoice(invoice: self)
  end

  def qbo_link
    return if qbo_id.to_i.zero?

    qbo_prefix + "invoice?txnId=#{qbo_id}"
  end

  private

  def qbo_prefix
    if Rails.env.production?
      'https://qbo.intuit.com/app/'
    else
      'https://sandbox.qbo.intuit.com/app/'
    end
  end
end
