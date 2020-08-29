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

    post '/api/v1/sessions', params:
      {
        'email': 'whatever@example.com',
        'password': 'pw123'
      }
  end

  it 'logs out a user' do
    expect(session[:user_id]).to eq(@user.id)

    delete "/api/v1/sessions/#{@user.id}"

    output = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(output[:data][:attributes][:message]).to eq('Successfully logged out.')
    expect(session[:user_id]).to eq(nil)
  end






end
