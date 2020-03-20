# frozen_string_literal: true

task user_processor: :environment do
  users = User.all
  users.map do |user|
    UserJob.perform_later user.id
  end
end
