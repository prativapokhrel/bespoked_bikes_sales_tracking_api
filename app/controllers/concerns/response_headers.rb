# frozen_string_literal: true

# app/controllers/concerns/response_headers.rb
module ResponseHeaders
  extend ActiveSupport::Concern

  included do
    after_action :set_total_count_header
  end

  private

  def set_total_count_header
    response.headers['X-Total-Count'] = instance_variable_get("@#{controller_name}").try(:count).to_s
  end
end
