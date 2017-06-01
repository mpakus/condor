# frozen_string_literal: true

RSpec.describe Flight::Airports, :vcr do
  let(:airports) { Flight::Airports.new('Melbourne').perform }
  let(:wrong_airports) { Flight::Airports.new('MelbourneA').perform }

  it 'gets list of airports' do
    expect(airports).to be_kind_of(Array)
  end

  it 'and list has correct structure with code and name fields' do
    %w[
      airportCode airportName cityCode cityName countryCode countryName latitude longitude stateCode timeZone
    ].each do |port|
      fields.each { |f| expect(port[f]).not_to be_nil }
    end
  end
end
