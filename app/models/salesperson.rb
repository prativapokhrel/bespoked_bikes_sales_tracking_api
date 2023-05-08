# frozen_string_literal: true

class Salesperson < ApplicationRecord

  #associations
  belongs_to :manager
  has_many :sales

  #validations
  validates_uniqueness_of :phone, scope: %i[first_name last_name]

  validates_presence_of :first_name, :last_name, :start_date, :phone, :manager

  #scopes
  default_scope { order(created_at: :desc) }
end
