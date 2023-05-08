# frozen_string_literal: true

class Customer < ApplicationRecord
  has_many :sales

  validates_presence_of :first_name, :last_name, :start_date
end
