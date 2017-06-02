# frozen_string_literal: true

RSpec.describe Flight::Search, :vcr do
  let(:flight_date) { Date.parse('2017-12-05') }
  let(:flights) { Flight::Search.new('Sydney', 'Heathrow', flight_date.strftime('%Y-%m-%d')).perform! }

  it 'gets list of flights' do
    expect(flights).to be_kind_of(Hash)
  end

  it 'has flights in 5 days interval' do
    expect(flights.keys.count).to eq 5
    (flight_date - 2..flight_date + 2).each do |date|
      expect(flights[date.strftime('%Y-%m-%d')]).not_to be_empty
    end
  end
end
