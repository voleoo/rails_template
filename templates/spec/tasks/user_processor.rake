require 'spec_helper'
require 'rake'

describe 'create logs rake task' do
  before do
    load File.expand_path("../../../lib/tasks/user_processor.rake", __FILE__)
    Rake::Task.define_task(:environment)
  end

  it "should process user" do
    create(:user)
    Rake::Task["user_processor"].invoke
    expect(User.all).to be_any
    User.all.each { |user|
      expect(user.reload.sign_in_count).to eq(1)
    }
  end
end
