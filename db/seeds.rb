# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'


# add mountains from mountains csv
CSV.foreach("./db/data/mountains.csv", :headers => true) do |row|
  attributes = {
    name: row[0],
    latitude: row[1],
    longitude: row[2],
    height: row[3]
  }

  mountain = Mountain.where(attributes)

  if mountain.first.nil?
    Mountain.create(attributes)
  end

end
