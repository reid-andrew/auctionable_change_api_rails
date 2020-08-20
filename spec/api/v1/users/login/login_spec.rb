require 'rails_helper'

RSpec.describe 'Login Endpoint - ', type: :request do
  before(:each) do
    @user = User.create(
      first_name: 'Joe',
      last_name: 'Strummer',
      email: 'whatever@example.com',
      password: 'pw123',
      password_confirmation: 'pw123'
    )
    @user.save
  end

  it 'logs in a user' do
    post '/api/v1/login', params:
      {
        'email': 'whatever@example.com',
        'password': 'pw123'
      }

    output = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(output[:data][:first_name]).to eq('Joe')
    expect(output[:data][:last_name]).to eq('Strummer')
  end
end
