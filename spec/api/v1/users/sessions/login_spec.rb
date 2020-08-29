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
    post '/api/v1/sessions', params:
      {
        'email': 'whatever@example.com',
        'password': 'pw123'
      }

    output = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(output[:data][:attributes][:first_name]).to eq('Joe')
    expect(output[:data][:attributes][:last_name]).to eq('Strummer')
  end

  it 'validates presence of fields before logging in' do
    post '/api/v1/sessions', params:
      {
        'password': 'abc'
      }

    output = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(output[:data][:attributes][:error]).to eq("Please provide a password and email.")
  end

  it 'validates email before logging in' do
    post '/api/v1/sessions', params:
      {
        'email': 'not_registered@example.com',
        'password': 'pw123'
      }

    output = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(output[:data][:attributes][:error]).to eq("Please register or provide correct login information.")
  end

  it 'validates password before logging in' do
    post '/api/v1/sessions', params:
      {
        'email': 'whatever@example.com',
        'password': 'abc'
      }

    output = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(output[:data][:attributes][:error]).to eq("Please register or provide correct login information.")
  end
end
