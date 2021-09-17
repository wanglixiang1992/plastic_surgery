# frozen_string_literal: true

class InvoicesController < ApplicationController
  def index
    authorize_action

    render :index, locals: { invoices: Invoice.all }
  end

  def new
    authorize_action

    invoice = Invoice.new
    render :new, locals: { invoice: invoice, customers: customers }
  end

  def create
    authorize_action

    invoice_creator = InvoiceCreator.new
    invoice_creator.call(invoice_params, line_item_params)
    if invoice_creator.success?
      redirect_to invoices_path, notice: I18n.t('invoice.created')
    else
      render :new, locals: { invoice: invoice_creator.invoice, customers: customers }
    end
  end

  private

  def authorize_action(record = Invoice)
    authorize(record, "#{action_name}?", policy_class: policy_class)
  end

  def policy_class
    InvoicePolicy
  end

  def invoice_params
    params.require(:invoice).permit(
      :customer_id, :invoice_date, :due_date, :amount, :memo, :invoice_number, :account_number
    )
  end

  def line_item_params
    params.require(:invoice).require(:line_item).permit(:description, :quantity, :unit_price)
  end

  def customers
    Customer.all
  end
end
