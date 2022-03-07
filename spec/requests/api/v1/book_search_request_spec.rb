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

    it 'returns data' do
      expect(books).to be_a(Hash)
      expect(books).to have_key(:data)
      expect(books[:data]).to be_a(Hash)

      expect(books[:data]).to have_key(:id)
      expect(books[:data][:id]).to eq("null")

      expect(books[:data]).to have_key(:type)
      expect(books[:data][:type]).to eq("books")

      expect(books[:data]).to have_key(:attributes)
      expect(books[:data][:attributes]).to be_a(Hash)

      expect(books[:data][:attributes]).to have_key(:destination)
      expect(books[:data][:attributes][:destination]).to be_a(String)

      expect(books[:data][:attributes]).to have_key(:forecast)
      expect(books[:data][:attributes][:forecast]).to be_a(Hash)
      expect(books[:data][:attributes][:forecast]).to have_key(:summary)
      expect(books[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(books[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(books[:data][:attributes][:forecast][:temperature]).to be_a(String)

      expect(books[:data][:attributes]).to have_key(:total_books_found)
      expect(books[:data][:attributes][:total_books_found]).to be_an(Integer)

      expect(books[:data][:attributes]).to have_key(:books)
      expect(books[:data][:attributes][:books]).to be_an(Array)

      book = books[:data][:attributes][:books].first

      expect(book).to be_a(Hash)
      expect(book).to have_key(:isbn)
      expect(book[:isbn]).to eq(nil).or be_an(Array)
      expect(book).to have_key(:title)
      expect(book[:title]).to be_a(String)
      expect(book).to have_key(:author)
      expect(book[:author]).to be_an(Array)
      expect(book[:author].first).to be_a(String)
      expect(book).to have_key(:publisher)
      expect(book[:publisher]).to be_an(Array)
      expect(book[:publisher].first).to be_a(String)
    end
  end
end
