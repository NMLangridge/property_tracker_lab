require('pg')

class Property

  attr_accessor :address, :value, :number_of_bedrooms, :year_built, :buy_let_status, :square_footage, :build

  attr_reader :id

  def initialize(options)
    @address = options['address']
    @value = options['value'].to_i()
    @number_of_bedrooms = options['number_of_bedrooms'].to_i()
    @year_built = options['year_built'].to_i()
    @buy_let_status = options['buy_let_status']
    @square_footage = options['square_footage'].to_i()
    @build = options['build']
  end

  def Property.all()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "SELECT * FROM property_tracker"
    db.prepare("all", sql)
    properties = db.exec_prepared("all")
    db.close()
    return properties.map {|property|
    Property.new(property)};
  end

  def save()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "INSERT INTO property_tracker (address, value, number_of_bedrooms, year_built, buy_let_status, square_footage, build
    ) VALUES (
      $1, $2, $3, $4, $5, $6, $7
    )
    RETURNING *"
    values = [@address, @value, @number_of_bedrooms, @year_built, @buy_let_status, @square_footage, @build]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]['id'].to_i()
    db.close()
  end
end
