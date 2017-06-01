# frozen_string_literal: true

module Flight
  # Search flights from - to on date
  class Search
    attr_reader :from, :to, :date

    def initialize(from, to, date)
      @from = from
      @to = to
      @date = date
    end

    def perform
      [{ from: from, to: to, date: date }]
    end
  end
end
