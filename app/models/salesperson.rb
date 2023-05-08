# frozen_string_literal: true

class Salesperson < ApplicationRecord
  belongs_to :manager
  has_many :sales

  validates_uniqueness_of :phone, scope: %i[first_name last_name]

  validates_presence_of :first_name, :last_name, :start_date, :phone, :manager
end
