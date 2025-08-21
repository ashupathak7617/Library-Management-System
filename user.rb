require 'byebug'

class User

  attr_accessor :id, :name, :email, :password , :type
  @@users = []
  @@errors = []
  @@num = 1
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
  def initialize(name, email, password)
    @id = @@num
    @name = name
    @email = email
    @password = password
    @type = self.class
  end

  def save
    @@num += 1
    @@users << { id: id, name: name, email: email, password: password, type: type } if valid
  end

  def self.alll
    @@users
  end

  def self.all
    @@users.any?{ |user| puts "Id: #{user[:id]} Name: #{user[:name]}, Email: #{user[:email]}, type: #{user[:type]}"}
    Main.start
  end
  def valid
    !!(self.email =~ VALID_EMAIL_REGEX)
  end

  def self.find_by_email_or_passwrod(email, password)
    validate_email(email)
    @@users.find{ |user| user[:email] == email && user[:password] == password }
  end

  def self.validate_email(email)
    if (email =~ VALID_EMAIL_REGEX)
      true
    else
      @@errors << "Email foramte is not valid"
    end
  end
end
