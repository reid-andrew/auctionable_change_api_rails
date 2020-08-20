require 'rails_helper'

RSpec.describe 'Registration Endpoint - ', type: :request do
  before(:each) do
    @starting_user_count = User.count
  end

  it 'registers a user' do
    post '/api/v1/users', params:
      {
        'first_name': 'Joe',
        'last_name': 'Strummer',
        'email': 'whatever@example.com',
        'password': 'pw123',
        'password_confirmation': 'pw123'
      }

    output = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(output[:data][:id]).to eq(User.last.id.to_s)
    expect(output[:data][:type]).to eq('users')
    expect(output[:data][:attributes][:email]).to eq('whatever@example.com')
    expect(User.count - @starting_user_count).to eq(1)
    expect(User.last.email).to eq("whatever@example.com")
  end

  it 'checks for duplicate emails before registration' do
    user = User.create(
      first_name: 'Mick',
      last_name: 'Jones',
      email: 'whatever@example.com',
      password: 'pw123',
      password_confirmation: 'pw123'
    )
    user.save

    post '/api/v1/users', params:
      {
        'first_name': 'Mick',
        'last_name': 'Jones',
        'email': 'whatever@example.com',
        'password': 'pw123',
        'password_confirmation': 'pw123'
      }

    output = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(output[:data][:attributes][:error]).to eq("This email is already registered.")
    expect(User.count - @starting_user_count).to eq(1)
  end

  it 'checks for mismatched passwords before registration' do
    post '/api/v1/users', params:
      {
        'first_name': 'Mick',
        'last_name': 'Jones',
        'email': 'whatever@example.com',
        'password': 'pw123',
        'password_confirmation': '123'
      }

    output = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(output[:data][:attributes][:error]).to eq("Passwords must match.")
  end

  it 'checks for incomplete before registration' do
    post '/api/v1/users', params:
      {
        'first_name': 'Mick',
        'password': 'pw123',
        'password_confirmation': 'pw123'
      }

    output = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    expect(output[:data][:attributes][:error]).to eq("Complete all fields.")
  end
end
