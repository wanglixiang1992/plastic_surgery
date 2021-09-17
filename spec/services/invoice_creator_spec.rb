# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvoiceCreator, type: :service do
  before do
    allow(QuickbooksSynchronizer).to receive(:new).and_return(sync_service)
  end

  let(:customer) { create(:customer) }
  let(:sync_service) { instance_double(QuickbooksSynchronizer, sync_invoice: true) }
  let(:service) { described_class.new }

  let(:valid_invoice) { eval(File.read('./spec/data/invoice/valid.json')) }
  let(:invalid_invoice) { eval(File.read('./spec/data/invoice/invalid.json')) }

  describe '#call' do
    context 'with valid' do
      it 'creates new invoice' do
        result = service.call(valid_invoice.except(:line_item).merge(customer_id: customer.id), valid_invoice[:line_item])
        expect(service.success?).to be_truthy
        expect(service.invoice.invoice_number).to eq(valid_invoice[:invoice_number])
      end

      it 'creates line item' do
        result = service.call(valid_invoice.except(:line_item).merge(customer_id: customer.id), valid_invoice[:line_item])
        expect(service.success?).to be_truthy
        expect(service.invoice.line_items.first.description).to eq(valid_invoice[:line_item][:description])
      end
    end

    context 'with invalid' do
      it 'returns error' do
        result = service.call(invalid_invoice.except(:line_item), invalid_invoice[:line_item])
        expect(service.success?).to be_falsey
      end
    end
  end
end
