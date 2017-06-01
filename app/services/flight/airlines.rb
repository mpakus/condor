# frozen_string_literal: true

require_relative('../request')

module Flight
  # Returns list of Airlines
  class Airlines
    def perform
      JSON.parse(Request.fetch('http://node.locomote.com/code-task/airlines'))
    end
  end
end
