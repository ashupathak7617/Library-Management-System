require 'byebug'
# require_relative 'main'

class Library

  attr_accessor :id, :name, :department
  @@library = []
  @@num = 1
  def initialize(name, department)
    @name = name
    @department = department
    @id = @@num

  end

  def self.menu
    puts "Enter 1 → Create a New Library\nEnter 2 → View All Libraries\nEnter 3 → Go Back\nEnter 4 → View Library Books"
    val = gets.to_i
    case val
    when 1
      new_library
    when 2
      all
      menu
    when 3
      Main.admin_features
    when 4
      library_books
      menu
    else
      puts "Please Enter Valid Input"
      menu
    end
  end

  def save
    @@library << { id:@id, name: @name, department: department }
    @@num += 1
  end

  def self.alll
    @@library
  end

  def self.new_library
    puts "Enter Library Name\n"
    name = gets.to_s.chop
    puts "Enter Library Department"
    dep = gets.to_s.chop
    Library.new(name, dep).save
    puts "Library Successfully Created"
    menu
  end

  def self.all
    # @@library.map{ |lib| puts "Id: #{lib[:id]}, Name: #{lib[:name]}, Department: #{lib[:department]}"}
    puts"here #{@@library.count} Library are avaiable "

    rows =  @@library.map do |lib|
      [lib[:id] , lib[:name] ,lib[:department]]
    end

    table = Terminal::Table.new(
      title: "Library List",
      headings: ['ID', 'Title', 'Author'],
      rows: rows
    )
    puts table
    @@library
  end

  def self.library_books

    puts "Enter The Library Id To View Books"
    li_id = gets.to_i
    books = Book.all.select do |book|
      byebug
      book[:lib_id] == li_id
    end
    byebug
    rows = books.map{ |book| [book[:id], book[:title], book[:author], book[:available]]}
    byebug
    table = Terminal::Table.new(title:"Library Books", headings: ['Id', 'Title', 'Author','Avaiable'], rows: rows)
    puts table
  end
end
