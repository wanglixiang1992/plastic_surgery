# frozen_string_literal: true

class InvoicePolicy < ApplicationPolicy
  def index?
    true
  end

  def new?
    true
  end

  def create?
    new?
  end
end
