# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 50.times do |n|
#   Task.create!(
#     title: '書類作成',
#     content: '企画書を作成する。',
#     deadline_on: Date.today + n.day,
#     status: Task.statuses.keys.sample,
#     priority: Task.priorities.keys.sample

#   )
# end
50.times do |n|
User.create!(
  name: "ccc",
  email: "cccc@gmail.com",
  password: "cccc@gmail.com",
  admin: true
)
end

50.times do |n|
  User.create!(
    name: "false",
    email: "false@gmail.com",
    password: "false@gmail.com",
    admin: false
  )
end