# frozen_string_literal: true

module RequestHelper
  def parsed_body
    JSON.parse(response.body)
  end
end
