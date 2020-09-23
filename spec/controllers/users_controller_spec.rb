require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'renders the new template' do
      get :new, {}
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with invalid params' do
      it 'validates the presence of the user\'s password' do
        post :create, params: { user: { email: 'jen@hotmail.com' } }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to eq(['Password digest Password can\'t be blank'])
      end

      it 'validates the presence of the user\'s email' do
        post :create, params: { user: { password: 'thepassword' } }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to eq(['Email can\'t be blank'])
      end

      it 'validates that the password is at least 6 characters' do
        post :create, params: { user: { email: 'jen@hotmail.com', password: '12345'} }
        expect(response).to render_template(:new)
        expect(flash[:errors]).to eq(['Password is too short (minimum is 6 characters)'])
      end
    end

    context 'with valid params' do
      # don't know if this is a good way to test mail
      after(:context) { ActionMailer::Base.deliveries.clear }

      it 'redirects user to bands index on success' do
        post :create, params: { user: { email: 'jen@hotmail.com', password: '123456'} }
        email = ActionMailer::Base.deliveries.last
        expect(email.subject).to eq('Please confirm your account')
        expect(email.to).to eq(['jen@hotmail.com'])
        expect(response.body).to eq('Please check your email to activate your account.')
      end
    end
  end
end
