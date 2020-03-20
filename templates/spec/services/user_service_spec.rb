# frozen_string_literal: true

require 'spec_helper'

describe UserService do
  describe '#processor' do
    it 'should return user' do
      user = create(:user)
      user_service = UserService.new(user).processor
      expect(user_service).to eq(user)
    end
  end
end
