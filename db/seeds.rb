# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create! fullname: "Tuan", email: "tuan@gmail.com", password: "111111",
  password_confirmation: "111111", is_admin: true
User.create! fullname: "user1", email: "user1@gmail.com", password: "password",
  password_confirmation: "password", is_admin: false
User.create! fullname: "LinhND", email: "linh@framgia.com", password: "111111",
  password_confirmation: "111111", is_admin: false

3.times do |n|
  Category.create! name: "Basic#{n}"
end

Lesson.create! category_id: "1", user_id: "3"

20.times do |m|
  3.times do |n|
    Word.create! name: "word#{m+n}", category_id: "#{n+1}"
  end
end

4.times do |n|
  Answer.create! answer_content: "answer#{n}", word_id: "#{n+1}"
end

4.times do |n|
  Result.create! lesson_id: "1", answer_id: "#{n}", word_id: "#{n+3}"
end
