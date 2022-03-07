require 'rails_helper'

RSpec.describe 'Book Search Endpoint' do
  describe 'book_search' do
    before(:each) do
      VCR.insert_cassette('denver_books')
    end
    after(:each) do
      VCR.eject_cassette('denver_books')
    end

    let!(:books) { BookService.book_search("denver") }
    let!(:book) { books[:docs].first }

    it 'returns response hash' do
      expect(books).to be_a(Hash)
    end

    it 'response hash contains docs array' do
      expect(books).to have_key(:docs)
      expect(books[:docs]).to be_an(Array)
    end

    it 'array elements contain book info hash' do
      expect(book).to be_a(Hash)
      expect(book).to have_key(:title)
      expect(book[:title]).to be_a(String)

      expect(book).to have_key(:isbn)
      expect(book[:isbn]).to be_an(Array)
      expect(book[:isbn].first).to be_a(String)

      expect(book).to have_key(:publisher)
      expect(book[:publisher]).to be_an(Array)
      expect(book[:publisher].first).to be_a(String)

      expect(book).to have_key(:author_name)
      expect(book[:author_name]).to be_an(Array)
      expect(book[:author_name].first).to be_a(String)
    end 
  end
end
