# frozen_string_literal: true

require 'spec_helper'

RSpec.describe User do
  it 'create user' do
    user = create(:user)

    expect(user).to be_present
  end
end
