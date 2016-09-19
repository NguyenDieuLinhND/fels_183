namespace :delayjob do
  desc "TODO"
  task mailmonth: :environment do
    User.all.each do |user|
      word_count = User.word_learned user
      MonthlyWorker.perform_async user.id, word_count
    end
  end
end
