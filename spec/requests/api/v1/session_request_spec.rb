require 'rails_helper'

RSpec.describe 'User Login Endpoint' do
  describe 'POST sessions' do
    before(:each) do
      user_params = { email: "jeff@email.com", password: "password123", password_confirmation: "password123" }
      post '/api/v1/users', params: user_params
      user_login_params = { email: "jeff@email.com", password: "password123" }
      post '/api/v1/sessions', params: user_login_params
    end

    let!(:login) { JSON.parse(response.body, symbolize_names: true) }

    it 'returns successful' do
      expect(response).to be_successful
    end

    it 'returns response hash with data key' do
      expect(login).to be_a(Hash)
      expect(login).to have_key(:data)
      expect(login[:data]).to be_a(Hash)
    end

    it 'returns correct data' do
      expect(login[:data]).to have_key(:type)
      expect(login[:data][:type]).to eq('user')

      expect(login[:data]).to have_key(:id)
      expect(login[:data][:id]).to be_a(String)

      expect(login[:data]).to have_key(:attributes)
      expect(login[:data][:attributes]).to be_a(Hash)

      expect(login[:data][:attributes]).to have_key(:email)
      expect(login[:data][:attributes][:email]).to be_a(String)

      expect(login[:data][:attributes]).to have_key(:api_key)
      expect(login[:data][:attributes][:api_key]).to be_a(String)
    end

    it 'does not contain sensitive user data' do
      expect(login[:data][:attributes]).to_not have_key(:password)
      expect(login[:data][:attributes]).to_not have_key(:password_digest)
    end

    it 'returns 401 error for failed authorization' do
      user_params = { email: "amy@email.com", password: "password123", password_confirmation: "password123" }
      post '/api/v1/users', params: user_params
      user_login_params = { email: "amy@email.com", password: "password124" }
      post '/api/v1/sessions', params: user_login_params
      error = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(401)
      expect(error[:error]).to eq("Invalid credentials.")
    end

    it 'returns 404 error for user not found' do
      user_login_params = { email: "nobody@email.com", password: "password124" }
      post '/api/v1/sessions', params: user_login_params
      error = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)
      expect(error[:error]).to eq("User not found. Please create an account.")
    end 
  end
end
