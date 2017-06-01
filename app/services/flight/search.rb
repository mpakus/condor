# frozen_string_literal: true

module Flight
  class ErrorAirport < StandardError; end

  # Search flights from - to on date
  class Search
    attr_reader :from, :to, :date

    def initialize(from, to, date)
      @from = from
      @to = to
      @date = date
    end

    def perform!
      airports_from, airports_to = find_airports
    end

    private

    def find_airports
      airports_from = Flight::Airports.new(from).perform
      airports_to = Flight::Airports.new(to).perform
      raise ErrorAirport.new("Can't find the departure airport") unless airports_from.any?
      raise ErrorAirport.new("Can't find the departure airport") unless airports_to.any?
      [airports_from, airports_to]
    end
  end
end
