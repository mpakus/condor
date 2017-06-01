# frozen_string_literal: true

RSpec.describe Flight::Airlines, :vcr do
  let(:airlines) { Flight::Airlines.new.perform }

  it 'gets list of airlines' do
    expect(airlines).to be_kind_of(Array)
  end

  it 'and list has correct structure with code and name fields' do
    airlines.each do |air|
      expect(air['code']).not_to be_nil
      expect(air['name']).not_to be_nil
    end
  end
end
