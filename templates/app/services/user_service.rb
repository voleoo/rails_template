class UserService
  def initialize(user)
    @user = user
  end

  def processor
    @user.update_attributes(sign_in_count: 1)
    @user
  end
end
