require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'Create an account'
  end

  feature 'signing up a user' do
    before(:each) do
      visit new_user_url
      fill_in 'email', with: 'testing@email.com'
      fill_in 'password', with: 'biscuit'
      find('#submit-form').click
      # two submit forms on page (one in header); created custom id to target correct one
    end

    scenario 'redirects to bands index page after signup' do
      expect(page).to have_content 'Please check your email to activate your account.'
      expect(page).to have_content 'Bands:'
    end
  end

  feature 'with an invalid user' do
    before(:each) do
      visit new_user_url
      fill_in 'email', with: 'testing@email.com'
      find('#submit-form').click
    end

    scenario 're-renders the signup page after a failed signup' do
      expect(page).to have_content('Create an account')
      expect(page).to have_content('Password can\'t be blank')
    end
  end
end