# frozen_string_literal: true

require_relative('../request')

module Flight
  class ErrorAirport < StandardError; end

  # Search flights from - to on date
  class Search
    def initialize(from, to, date)
      @from = from
      @to = to
      @date = date
    end

    def perform!
      airports_from, airports_to = find_airports

      results = []
      airlines.each do |airline|
        airports_from.each do |from|
          airports_to.each do |to|
            results << flight_search(airline['code'], @date, from, to)
          end
        end
      end
      results
    end

    private

    def airlines
      Flight::Airlines.new.perform
    end

    def flight_search(airline_code, date, from, to)
      url = "http://node.locomote.com/code-task/flight_search/#{airline_code}?date=#{date}&from=#{from}&to=#{to}"
      puts url
      JSON.parse(Request.fetch(url))
    end

    def find_airports
      airports_from = Flight::Airports.new(@from).perform
      airports_to = Flight::Airports.new(@to).perform
      raise ErrorAirport.new("Can't find the departure airport") unless airports_from.any?
      raise ErrorAirport.new("Can't find the departure airport") unless airports_to.any?
      [airports_from.map{|a| a['airportCode']}, airports_to.map{|a| a['airportCode']}]
    end
  end
end
