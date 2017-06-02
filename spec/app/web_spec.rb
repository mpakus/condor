# frozen_string_literal: true

require_relative('../spec_helper.rb')

RSpec.describe Web do
  def app
    Web
  end

  it 'should allow accessing the home page' do
    get '/'
    expect(last_response).to be_ok
  end

  it 'should allow accessing the /airlines page' do
    get '/'
    expect(last_response).to be_ok
  end

  it 'should allow accessing the /airports?q=SYD page' do
    get '/'
    expect(last_response).to be_ok
  end

  it 'should allow accessing the /search?date=2017-12-05&from=SYD&to=JFK' do
    get '/'
    expect(last_response).to be_ok
  end
end
