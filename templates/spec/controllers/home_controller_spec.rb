# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  render_views

  describe '#index' do
    it 'should success' do
      get :index

      expect(response).to have_http_status(200)
    end
  end
end
