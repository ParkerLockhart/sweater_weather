require 'rails_helper'

RSpec.describe BookFacade do
  describe 'book_search' do
    it 'returns books about city' do
      VCR.use_cassette('denver_books') do
        facade = BookFacade.book_search('denver', 10)
        total_results = facade.first
        books = facade.last

        expect(total_results).to eq(52)
        expect(books.count).to eq(10)

        books.each do |book|
          expect(book).to be_instance_of(Book)
        end
      end
    end
  end
end
