# frozen_string_literal: true

require 'rails_helper'

describe 'accessibility', type: :feature do
  it 'home page' do
    visit root_path

    expect(page).to has_css? 'body'
  end
end
