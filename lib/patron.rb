class Patron
  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id].to_i
  end

  def self.all
    entire_patrons = []
    results = DB.exec("SELECT * FROM patrons;")
    # binding.pry
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      entire_patrons << Patron.new({:name => name, :id => id})
    end
    entire_patrons
  end

  def save
    results = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_patron)
    self.name == another_patron.name
  end

end