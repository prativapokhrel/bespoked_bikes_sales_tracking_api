# frozen_string_literal: true

class Customer < ApplicationRecord

  #associations
  has_many :sales

  #validations
  validates_presence_of :first_name, :last_name, :start_date

  #scopes
  default_scope { order(created_at: :desc) }
end
