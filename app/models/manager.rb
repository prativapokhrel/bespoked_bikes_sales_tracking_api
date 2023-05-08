# frozen_string_literal: true

class Manager < ApplicationRecord

  #associations
  has_many :salespeople

  #scopes
  default_scope { order(created_at: :desc) }
end
