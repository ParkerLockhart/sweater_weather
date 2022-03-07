require 'rails_helper'

RSpec.describe Book do
  let!(:data) { title: "book title", isbn: ["isbn"], publisher: ["publisher"], author_name: ["John Doe"] }
  let!(:book) { Book.new(data) }

  it 'exists' do
    expect(book).to be_instance_of(Book)
  end

  it 'has attributes' do
    expect(book.title).to eq("book title")
    expect(book.isbn).to eq("isbn")
    expect(book.publisher).to eq("publisher")
    expect(book.author).to eq("John Doe")
  end
end 
