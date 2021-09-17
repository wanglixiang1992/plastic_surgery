# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvoicesController, type: :controller do
  before do
    allow(InvoicePolicy).to receive(:new).and_return(invoice_policy)
    allow(QuickbooksSynchronizer).to receive(:new).and_return(sync_service)
  end

  let(:customer) { create(:customer) }
  let(:invoice_policy) { instance_double(InvoicePolicy, index?: true, create?: true) }
  let(:sync_service) { instance_double(QuickbooksSynchronizer, sync_invoice: true) }

  let(:valid_invoice) { eval(File.read('./spec/data/invoice/valid.json')) }
  let(:invalid_invoice) { eval(File.read('./spec/data/invoice/invalid.json')) }

  describe 'GET index' do
    context 'with valid' do
      before do
        get :index
      end

      it { is_expected.to respond_with(:ok) }
      it { is_expected.to render_template(:index) }
    end
  end

  describe 'POST create' do
    context 'with valid' do
      before do
        post :create, params: { invoice: valid_invoice.merge(customer_id: customer.id) }
      end

      it { is_expected.to respond_with(:found) }
      it { is_expected.to redirect_to(invoices_path) }
    end

    context 'with invalid' do
      before do
        post :create, params: { invoice: invalid_invoice }
      end

      it { is_expected.to render_template(:new) }
    end
  end
end
