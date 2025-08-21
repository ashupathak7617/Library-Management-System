require 'byebug'
require 'terminal-table'
require_relative 'books'
require_relative 'user'

class Member < User
  class << self
    attr_accessor :current_user
  end
  @@borrowed_books = []
  def self.start
    puts "Welcome To The Customers Panel\n\nPress 1 ~ To View Books\nPress 2 ~ Borrow Book\nPress 3 ~ View Borrowed Books\nPress 4 ~ Retrun Book\nPress 5 ~ Logout\nPress 6 ~ Exit The Program"
    val = gets.to_i
    case val
    when 1
      get_books
      start
    when 2
      borrow_book
      start
    when 3
      get_borrowed_books
      start
    when 4
      return_book
      start
    when 5
      puts "Logout Successfully"
      Main.custormer_menu
    when 5
      puts "You are Successfully Exit"
      SystemExit
    else
      puts "Enter Valid Input"
      start
    end
  end

  def self.get_books
    puts "Which Department Books you Want?"
    rows = Library.alll.map{ |lib| [lib[:id], lib[:department]] }

    table = Terminal::Table.new(headings: ['Id','Department'], rows: rows)
    puts table,"\nEnter Department Id To see Books"
    dep_id  = gets.to_i
    books = Book.alll.select{ |book| book[:lib_id] == dep_id &&  book[:available] == "yes" &&book[:linked] = "true" }
    rows = books.map{ |book| [book[:id], book[:title], book[:author]] }
    table = Terminal::Table.new(title: "Books", headings: ['Id','Name', 'Email'], rows: rows)
    puts table

  end

  def self.get_members
    members = User.alll.select do |user|
      user[:type].to_s == "Member" end
    rows = members.map{ |member| [member[:id], member[:name], member[:email]] }
    table = Terminal::Table.new(title: "All Memers", headings:['Id','Name','Email'], rows: rows)
    puts table
  end

  def self.borrow_book

    rows = Book.available_books.map{ |a_book| [ a_book[:id], a_book[:title], a_book[:author]] }
    table = Terminal::Table.new(title: "Available books", headings: ['Id', 'Title', 'Author'], rows: rows)
    puts table
    puts "Enter the Book Id to borrow:"
    id = gets.to_i
    book = Book.available_books.find{ |book| book[:id] == id && book[:available] == "yes" }
    if book
      book[:available] = "no"
      book[:user_id] = current_user[:id]
      @@borrowed_books << { id: book[:id], title: book[:title], author: book[:author],user_id: book[:user_id], available: book[:available]}
      puts "#{ book[:title] } Book is Borrowed..!"
    else
      puts "Book Are Not available with #{id}"
    end
    start
  end

  def self.get_borrowed_books
    books =  @@borrowed_books.select{ |book| book[:user_id] == current_user[:id] && book[:available] == 'no' }


    rows = books.map{ |book| [book[:id], book[:title], book[:author]] }
    table = Terminal::Table.new(title: "Borrowed Books", headings: ['ID','Title','Author'], rows: rows)
    puts table

  end

  def self.return_book
    byebug
      puts get_borrowed_books,"\nEnter Book Id Which You Want To Retrun\n"
      b_id = gets.to_i
      book = @@borrowed_books.find{ |book| book[:id] == b_id}
      book[:available] = "yes"
      books = Book.alll.find{ |book| book[:id] == b_id}
      books[:available] = "yes"
      puts "Book Retruned By You"
  end
end
