# frozen_string_literal: true

class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  after_commit :generate_qbo_customer, on: :create

  def generate_qbo_customer
    QuickbooksSyncService.new.sync_customer(customer: self)
  end
end
