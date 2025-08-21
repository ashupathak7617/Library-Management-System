class Seed

  def self.run
    [
      { title: "ror", author: "ashu"},
      { title: "java", author: "ashu"},
      { title: "physics", author: "ashu"},
      { title: "math", author: "ashu"},
      { title: "account", author: "ashu"},
      { title: "business", author: "ashu"}
    ].each do |book|
      Book.new(book[:title], book[:author]).save
    end

    [
      { name: "ashu", email: "ashu@gmail.com", password: "1234" },
      { name: "sajju", email: "sajju@gmail.com", password: "1234" }

    ].each do |admin|
      AdminUser.new(admin[:name], admin[:email], admin[:password]).save
    end

    [
      { name: "dulla", email: "dulla@gmail.com", password: "1234" },
      { name: "lalli", email: "lalli@gmail.com", password: "12345" }

    ].each do |member|
      Member.new(member[:name], member[:email], member[:password]).save
    end

    [
      {name: "Expert", department: "Math Department"},
      {name: "Royal", department: "Commerece Department"},
      {name: "Technial", department: "It Department"},
    ].each do |lib|
      Library.new(lib[:name], lib[:department]).save
    end
  end
end
