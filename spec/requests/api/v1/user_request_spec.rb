require 'rails_helper'

RSpec.describe 'User Registration Endpoint' do
  describe 'POST users' do
    before(:each) do
      user_params = { email: "jeff@email.com", password: "password123", password_confirmation: "password123" }
      post '/api/v1/users', params: user_params
    end

    let!(:user) { JSON.parse(response.body, symbolize_names: true) }

    it 'returns successful' do
      expect(response).to be_successful
    end

    it 'returns response hash with data key' do
      expect(user).to be_a(Hash)
      expect(user).to have_key(:data)
      expect(user[:data]).to be_a(Hash)
    end

    it 'returns correct data' do
      expect(user[:data]).to have_key(:type)
      expect(user[:data][:type]).to eq('user')

      expect(user[:data]).to have_key(:id)
      expect(user[:data][:id]).to be_a(String)

      expect(user[:data]).to have_key(:attributes)
      expect(user[:data][:attributes]).to be_a(Hash)

      expect(user[:data][:attributes]).to have_key(:email)
      expect(user[:data][:attributes][:email]).to be_a(String)

      expect(user[:data][:attributes]).to have_key(:api_key)
      expect(user[:data][:attributes][:api_key]).to be_a(String)

      expect(user[:data][:attributes]).to_not have_key(:password)
      expect(user[:data][:attributes]).to_not have_key(:password_confirmation)
      expect(user[:data][:attributes]).to_not have_key(:password_digest)
    end

    it 'returns error message for password mismatch' do
      user_params = { email: "amy@email.com", password: "password123", password_confirmation: "password124" }
      post '/api/v1/users', params: user_params
      error = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(422)
      expect(error[:error]).to eq("passwords don't match.")
    end

    it 'returns error message for missing field' do
      user_params = { email: "", password: "password123", password_confirmation: "password123" }
      post '/api/v1/users', params: user_params
      error = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(422)
      expect(error[:error]).to eq("{:email=>[\"can't be blank\"]}")
    end

    it 'returns error message for email already taken' do
      user_params = { email: "jeff@email.com", password: "password123", password_confirmation: "password123" }
      post '/api/v1/users', params: user_params
      error = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(422)
      expect(error[:error]).to eq("{:email=>[\"has already been taken\"]}")
    end
  end
end
