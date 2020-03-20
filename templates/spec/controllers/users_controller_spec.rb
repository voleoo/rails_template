# frozen_string_literal: true

require 'spec_helper'

RSpec.describe UsersController do
  render_views

  describe '#index' do
    it 'should success' do
      get :index
      expect(response).to be_success
    end
  end
end
