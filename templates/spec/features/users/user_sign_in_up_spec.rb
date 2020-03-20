# frozen_string_literal: true

describe 'the sign_up process', type: :feature do
  it 'registration' do
    visit new_user_registration_path
    user = attributes_for(:user)

    fill_in 'Email', with: user[:email]
    fill_in 'Password', with: user[:password]
    fill_in 'Password confirmation', with: user[:password]

    click_button 'Sign up'
    expect(page).to have_content 'index.html.slim'
  end
end

describe 'the sign_in process', type: :feature do
  it 'login' do
    visit new_user_session_path
    user = create(:user, password: 'password_for_test')

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password_for_test'

    click_button 'Log in'
    expect(page).to have_content 'index.html.slim'
  end
end
