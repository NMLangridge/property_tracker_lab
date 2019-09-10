require('pg')

class Property

  attr_accessor :address, :value, :number_of_bedrooms, :year_built, :buy_let_status, :square_footage, :build

  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i() if options['id']
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

  def update()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "UPDATE property_tracker SET (address, value, number_of_bedrooms, year_built, buy_let_status, square_footage, build) = (
    $1, $2, $3, $4, $5, $6, $7
    ) WHERE id = $8"
    values = [@address, @value, @number_of_bedrooms, @year_built, @buy_let_status, @square_footage, @build, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def delete()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "DELETE FROM property_tracker WHERE id = $1"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

  def Property.delete_all()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "DELETE FROM property_tracker"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def Property.find_by_id(id)
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "SELECT * FROM property_tracker WHERE id = $1"
    values = [id]
    db.prepare("select", sql)
    properties = db.exec_prepared("select", values)
    db.close()
    return Property.new(properties[0]);
  end

  def Property.find_by_address(address)
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "SELECT * FROM property_tracker WHERE address = $1"
    values = [address]
    db.prepare("select", sql)
    properties = db.exec_prepared("select", values)
    db.close()
    return Property.new(properties[0]);
  end

end
