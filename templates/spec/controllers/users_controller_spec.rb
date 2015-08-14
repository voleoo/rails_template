require 'spec_helper'

RSpec.describe HomeController do
  render_views

  describe "#index" do
    it "should success" do
      get :index
      expect(response).to be_success
    end
  end
end
