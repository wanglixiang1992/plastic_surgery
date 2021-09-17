# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'Table structure' do
    it { is_expected.to have_db_column(:invoice_date).of_type(:date) }
    it { is_expected.to have_db_column(:due_date).of_type(:date) }
    it { is_expected.to have_db_column(:amount).of_type(:money) }
    it { is_expected.to have_db_column(:memo).of_type(:text) }
    it { is_expected.to have_db_column(:qbo_id).of_type(:string) }
    it { is_expected.to have_db_column(:invoice_number).of_type(:string) }
    it { is_expected.to have_db_column(:account_number).of_type(:string) }
  end

  describe 'Model relations' do
    it { is_expected.to belong_to(:customer) }
    it { is_expected.to have_many(:line_items).dependent(:destroy) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:invoice_date) }
    it { is_expected.to validate_presence_of(:amount) }
  end
end
