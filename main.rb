require_relative 'books'
require_relative 'members'
require_relative 'seed_data'
require_relative 'admin'
require_relative 'user'
require_relative 'library'

class Main

  def self.start
    puts "Welcome to this Programm"
    print "Enter 1 To Book Page\nEnter 2 To Member Page\nEnter 3 To all users\nEnter 4 To Exit\nEnter 5 To Customer Menu\nEnter 6 to Admin Menu"
    val = gets.to_i
    case val
    when 1
      Book.start
    when 2
      Member.start
    when 3
      User.all
    when 4
     SystemExit
    when 5
      custormer_menu
    when 6
      main_menu
    else
      puts "Enter Vaild Input"
      start
    end
  end

  def self.admin_features
    puts "Welcome to Admmin Panel"
    print "Enter 1 To Book Page\nEnter 2 To Library Page\nEnter 3 To all users\nEnter 4 To Exit\nEnter 5 To Customer Menu\nEnter 6 to Admin SignIn/SingUp Page\n"
    val = gets.to_i
    case val
    when 1
      Book.start
    when 2
      Library.menu
    when 3
      User.all
      admin_features
    when 4
     SystemExit
    when 5
      custormer_menu
    when 6
      main_menu
    else
      puts "Enter Vaild Input\n\n"
      admin_features
    end
  end

  def self.query
    Seed.run
    puts "Plese let me konw, Are you Admin User (yes/no)"
    res = gets.to_s.chop
    if res == "yes"
      main_menu
    else
      custormer_menu
    end
  end
  def self.main_menu
    puts "Welcome to Admin SignIn/SingUp Page\n"
    print "Enter 1 To Sign Up\nEnter 2 To Sign In\nEnter 3 To Exit\n"
    val = gets.to_i
    case val
    when 1
      puts "Welcome to sign up in page"
      user_input('sign_up', val)
    when 2
      puts "Welcome to sign up page"
      user_input('sign_in', val)
    when 3
      SystemExit
    else
      puts "Enter Vaild Input "
      main_menu
    end
  end

  def self.custormer_menu
    puts "Welcome to Customer User Menu"
    print "Enter 1 To Sign Up\nEnter 2 To Sign In\nEnter 3 To Exit\n"
    val = gets.to_i
    case val
    when 1
      puts "Welcome to sign up in page"
      user_input('c_sign_up', val)
    when 2
      puts "Welcome to sign up page"
      user_input('c_sign_in', val)
    when 3
      SystemExit
    else
      puts "Enter Vaild Input"
      custormer_menu
    end
  end

  def self.user_input(action, val)
    if val == 1
      puts "Enter Name"
      name = gets.to_s.chop
      puts "Enter Email"
      email = gets.to_s.chop
      puts "Enter Password"
      password = gets.to_s.chop

      send(action, name, email, password)
    else
      puts "Enter Email"
      email = gets.to_s.chop
      puts "Enter Password"
      password = gets.to_s.chop

      send(action, email, password)
    end
  end

  def self.sign_up(name, email, password)
    AdminUser.new(name, email, password).save
    puts "Admin Created Successfully"
    main_menu
  end

  def self.sign_in(email, passoword)
    user = User.find_by_email_or_passwrod(email, passoword)
    if user.any?
      admin_features
    else
      puts "not found"
      main_menu
    end
  end

  def self.c_sign_up(name, email, password)
    Member.new(name, email, password).save
    puts "Your account has created successfully"
    custormer_menu
  end

  def self.c_sign_in(email, passoword)
    user = User.find_by_email_or_passwrod(email, passoword)
    if user && user[:type].to_s == "Member"
      Member.current_user = user
      Member.start
    else
      puts "Cumstomer  not found"
      custormer_menu
    end
  end
end
Main.query
