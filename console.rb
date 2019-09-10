require('pry')
require_relative('./models/property.rb')

property1 = Property.new({
  'address' => '29 Bezak Street',
  'value' => 7000,
  'number_of_bedrooms' => 2,
  'year_built' => 1990,
  'buy_let_status' => 'let',
  'square_footage' => 50,
  'build' => 'bungalow'
  })

  property1.save()

  property2 = Property.new({
    'address' => '12 Lahndahn Road',
    'value' => 400000,
    'number_of_bedrooms' => 6,
    'year_built' => 1850,
    'buy_let_status' => 'buy',
    'square_footage' => 20000,
    'build' => 'mansion'
    })

properties = Property.all()
binding.pry
nil
