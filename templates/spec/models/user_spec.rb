require 'spec_helper'

RSpec.describe User do
  it "should create user" do
    user = create(:user)
    expect(user).to be_present
  end
end
