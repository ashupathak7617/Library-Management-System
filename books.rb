require 'byebug'
require 'terminal-table'

class Book
  @@books = []
  @@num = 1
  @@linked_books = []
  def initialize(title, author)
    @id = @@num
    @title = title
    @author = author
    @avaiable = "yes"
    @linked = "false"
    @lib_id = 0
    @user_id = 0
  end

  def self.start
    puts "Enter 1 Create New Book Record\nEnter 2 Display All Books\nEnter 3 Go Back to Main Menu\nEnter 4 Exit Program\nEnter 5 to Add Book to Library\nEnter 6 Show Unlinked Books (Not in Library)\nEnter 7 Show Library Inventory"
    val = gets.to_i
    case val
    when 1
      new_book
    when 2
      all
      start
    when 3
      Main.admin_features
    when 4
      puts "You are Succssfully Exits"
      SystemExit
    when 5
      add_books_to_library
      start
    when 6
      books_not_linked_with_library
      start
    when 7
      linked_books
      start
    else
      puts " Enter Valid Input"
      start
    end
  end

  def save
    @@num += 1
    @@books << { id: @id, title: @title, author: @author , available: @avaiable, linked: @linked, lib_id: @lib_id, user_id: @user_id}
  end

  def self.new_book
    puts "Welocme to Create New Book Page\n"
    puts "Enter Book Title"
    title = gets.to_s.chop
    puts "Enter Author Name"
    author = gets.to_s.chop
    Book.new(title, author).save
    puts "Book Created Successfully"
    start
  end

  def self.alll
    @@books
  end

  def self.all
    rows =  @@books.map do |book|
      [book[:id], book[:title], book[:author], book[:available]]
    end

    table = Terminal::Table.new(
      title: "Books List",
      headings: ['ID', 'Title', 'Author','Avaiable'],
      rows: rows
    )
    puts table
    @@books
  end

  def self.available_books
    available_books = @@books.select{ |book| book[:available] == "yes" && book[:linked] == "true" }
    if available_books.size > 0
      available_books.each do |a_book|
        puts "Id : #{ a_book[:id] }, Title: #{ a_book[:title] }, Author: #{ a_book[:author] }, Available: #{a_book[:available] }"
      end
    else
      puts "No Books Are Avaiable"
    end
    available_books
  end

  def self.books_not_linked_with_library
    books_not_linked_with_library = @@books.select{ |book| book[:linked] == "false" }
    if books_not_linked_with_library.size > 0
      books_not_linked_with_library.each do |a_book|
        puts "Id : #{ a_book[:id] }, Title: #{ a_book[:title] }, Author: #{ a_book[:author] }"
      end
    else
      puts "No Books Are Avaiable"
    end
    if books_not_linked_with_library
      rows = books_not_linked_with_library.map{ |book| [book[:id], book[:title], book[:author]]}
      table = Terminal::Table.new(
        title: "Books Not Stored In The library",
        headings: ['ID', 'Title', 'Author'],
        rows: rows
      )
      puts table
      books_not_linked_with_library
    else
      puts "No Books Are Avaiable"
    end
  end

  def self.add_books_to_library
    puts "Welcome To Add Book To Library Page\n\n"

    if books_not_linked_with_library
      books = books_not_linked_with_library.map { |book| [book[:id],book[:title], book[:author]] }
      table = Terminal::Table.new(title: "Books Which Are Not Stored In The library", headings: ['Id', 'Title', 'Author'], rows: books)

      puts table, "\n\n"
      puts "Enter The Book Id to Store in the library"

      ids = gets.chomp.split(",").map(&:strip).map(&:to_i)
      selected_books = @@books.select{ |book| ids.include?(book[:id])}
      rows = Library.alll.map{ |lib| [lib[:id], lib[:department]] }
      table = Terminal::Table.new(headings: ['Id','Department'], rows: rows)
      puts table,"\nEnter the Library Id To store Bookn\n"
      lib = gets.to_i
      if selected_books.empty?
        puts "No books found for given IDs."
      else
        selected_books.each do |book|
          book[:lib_id] = lib
          book[:linked] = "true"
          @@linked_books << book
          puts "ID: #{book[:id]}, Title: #{book[:title]}, Author: #{book[:author]}"
        end
      end
      puts "book Successfully Added To Library"
    else
      puts "No Books Are Avaiable"
    end
  end

  def self.linked_books
    books = @@books.select{ |book| book[:linked] == "true" && book[:available] == "true"}
    rows = books.map{ |book| [book[:id], book[:title], book[:author], book[:lib_id], book[:available]]}
    table = Terminal::Table.new(title: "Books Present In Library", headings: ['Id', 'Title','Author', 'Library Id', 'AvaiableSS'], rows: rows)
    puts table
  end

  # To Do=========
end
