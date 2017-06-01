# frozen_string_literal: true

RSpec.describe Flight::Search do
  it 'should return correct data' do
    Flight::Search.new('Sydney', 'Heathrow', '2016-09-10')
  end
end
