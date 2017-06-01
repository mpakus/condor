# frozen_string_literal: true

require_relative('../request')

module Flight
  # Search by query and returns list of Airports
  class Airports
    def initialize(q)
      @q = q
    end

    def perform
      JSON.parse(Request.fetch("http://node.locomote.com/code-task/airports?q=#{@q}"))
    end
  end
end
