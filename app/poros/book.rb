class Book
  attr_reader :title, :author, :publisher, :isbn

  def initialize(data)
    @title = data[:title]
    @author = data[:author_name].first
    @publisher = data[:publisher].first
    @isbn = data[:isbn].first
  end
end
