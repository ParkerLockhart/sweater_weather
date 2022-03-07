require 'rails_helper'

RSpec.describe 'Book Search Endpoint' do
  describe 'GET book-search' do
    before(:each) do
      VCR.insert_cassette('san_antonio')
      VCR.insert_cassette('san_antonio_weather')
      VCR.insert_cassette('san_antonio_books')
      get '/api/v1/book-search?location=san%20antonio,tx&quantity=5'
    end
    after(:each) do
      VCR.eject_cassette('san_antonio')
      VCR.eject_cassette('san_antonio_weather')
      VCR.eject_cassette('san_antonio_books')
    end

    let!(:books) { JSON.parse(response.body, symbolize_names: true) }

    it 'returns successful' do
      expect(response).to be_successful
    end

    xit 'returns data' do
    end
  end
end
