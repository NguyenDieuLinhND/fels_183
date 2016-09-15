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
  text = "text".center(100, "text")
  Category.create! name: "Basic#{n}"
end

20.times do |m|
  Word.create! name: "word#{m+1}", category_id: 1
  4.times do |t|
    t==3 ? is_correct = "true" : is_correct = "false"
    Answer.create! answer_content: "answer#{t}", word_id: "#{m+1}", is_correct: is_correct
  end
end

20.times do |m|
  Word.create! name: "word#{m+21}", category_id: 2
  4.times do |t|
    t==1 ? is_correct = "true" : is_correct = "false"
    Answer.create! answer_content: "answer#{t}", word_id: "#{m+21}", is_correct: is_correct
  end
end

20.times do |m|
  Word.create! name: "word#{m+41}", category_id: 3
  4.times do |t|
    t==0 ? is_correct = "true" : is_correct = "false"
    Answer.create! answer_content: "answer#{t}", word_id: "#{m+41}", is_correct: is_correct
  end
end

4.times do |n|
  Result.create! lesson_id: "1", answer_id: "#{n+1}", word_id: "#{n+3}"
end
