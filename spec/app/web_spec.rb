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
end
