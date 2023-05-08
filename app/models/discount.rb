# frozen_string_literal: true

class Discount < ApplicationRecord

  #associations
  belongs_to :product

  #scopes
  default_scope { order(created_at: :desc) }
end
