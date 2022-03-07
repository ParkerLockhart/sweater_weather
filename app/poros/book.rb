class Book
  attr_reader :title, :author, :publisher, :isbn

  def initialize(data)
    @title = data[:title]
    @author = data[:author_name]
    @publisher = data[:publisher]
    @isbn = data[:isbn] ? data[:isbn] : nil
  end
end
