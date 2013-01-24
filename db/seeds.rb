# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# :description, :number, :price
Plan.create(id: 1, number: 1, price: 19, description: 'One free linquet + One year service')
Plan.create(id: 2, number: 1, price: 25, description: 'One free linquets + One year service')
Plan.create(id: 3, number: 2, price: 45, description: 'Two free linquets + One year service')
Plan.create(id: 4, number: 4, price: 85, description: 'Four free linquets + One year service')
Plan.create(id: 5, number: 10, price: 195, description: 'Ten free linquets + One year service')
