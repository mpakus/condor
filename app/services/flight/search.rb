# frozen_string_literal: true

require_relative('../request')

module Flight
  # Airports not found
  class ErrorAirport < StandardError; end

  # Search flights from - to in 5 dates interval
  class Search
    def initialize(from, to, date)
      @from = from
      @to = to
      @date = date
    end

    # @return [Hash]
    def perform!
      results = {}
      airports_from, airports_to = find_airports(@from, @to)
      dates_interval.each do |date|
        next if date <= Date.today # skip days in the past
        date = date.strftime('%Y-%m-%d')
        results[date] = cross_flights_on_date(date, airports_from, airports_to)
      end
      results.each { |k, v| results[k] = v.value }
    end

    private

    # Search Departure and Destination Airports
    # @return [Array]
    def find_airports(from, to)
      airports_from = Flight::Airports.new(from).perform
      raise ErrorAirport, "Can't find the departure airport" unless airports_from.any?

      airports_to = Flight::Airports.new(to).perform
      raise ErrorAirport, "Can't find the departure airport" unless airports_to.any?

      [airports_from.map { |a| a['airportCode'] }, airports_to.map { |a| a['airportCode'] }]
    end

    # Creates interval of dates (date - 2, date - 1, date, date + 1, date + 5)
    # @return [Range]
    def dates_interval
      (Date.parse(@date) - 2..Date.parse(@date) + 2)
    end

    # Search all flights on that date
    # @return [Array]
    def cross_flights_on_date(date, airports_from, airports_to)
      # 5 Threads with Threads inside: Airlines * Departure Airports * Destination Airports
      Thread.new do
        results = []
        # Airlines * Departure Airports * Destination Airports
        airlines.each do |airline|
          airports_from.each do |from|
            airports_to.each { |to| results << flight_search(airline['code'], date, from, to) }
          end
        end
        # Thread.new.value then Up array 1 lvl and sort by price (cheapest on top)
        results.map(&:value).flatten.sort_by { |k| k['price'] }
      end
    end

    # Fetch list of Airlines
    # @return [Array]
    def airlines
      Flight::Airlines.new.perform
    end

    # Create Thread for search one flight from and to on date
    # @return [Thread]
    def flight_search(airline_code, date, from, to)
      Thread.new do
        url = "http://node.locomote.com/code-task/flight_search/#{airline_code}?date=#{date}&from=#{from}&to=#{to}"
        JSON.parse(Request.fetch(url))
      end
    end
  end
end
