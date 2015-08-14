class UserJob < ActiveJob::Base
  queue_as :default

  def perform(user_id)
    UserService.new(User.find(user_id)).processor
  end
end
