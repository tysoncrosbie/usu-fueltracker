puts
puts 'Creating Admins'

user = User.where(email: 'tyson@tysoncrosbie.com').first_or_create name: 'Tyson Crosbie', password: 'password'
user.add_role :admin
puts " - #{user.name}"

user = User.where(email: 'susan.crosbie@usu.edu').first_or_create name: 'Susan Crosbie', password: 'changethis'
user.add_role :admin
puts " - #{user.name}"


puts
puts 'Creating Roles:'

ROLES.each do |role|
  Role.where(name: role).first_or_create
  puts " - #{role}"
end


require File.expand_path('db/seeds/airports.rb')
require File.expand_path('db/seeds/planes.rb')
require File.expand_path('db/seeds/receipts.rb')




