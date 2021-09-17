# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LineItem, type: :model do
  describe 'Table structure' do
    it { is_expected.to have_db_column(:description).of_type(:string) }
    it { is_expected.to have_db_column(:unit_price).of_type(:money) }
    it { is_expected.to have_db_column(:quantity).of_type(:integer) }
  end

  describe 'Model relations' do
    it { is_expected.to belong_to(:invoice) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:invoice_id) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
