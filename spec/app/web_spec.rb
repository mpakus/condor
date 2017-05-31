require_relative('../spec_helper.rb')

RSpec.describe 'Web application' do
  it 'should allow accessing the home page' do
    get '/'
    expect(last_response).to be_ok
  end
end