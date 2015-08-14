task user_processor: :environment do
  users = User.all
  users.map { |user|
    UserJob.perform_later user.id
  }
end
