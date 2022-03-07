require 'rails_helper'

RSpec.describe BookFacade do
  describe 'book_search' do
    it 'returns books about city' do
      VCR.use_cassette('denver_books') do
        books = BookFacade.book_search('denver', 10)

        expect(books.count).to eq(10)

        books.each do |book|
          expect(book).to be_instance_of(Book)
        end
      end
    end
  end
end
