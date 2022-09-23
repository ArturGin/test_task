# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let!(:posts) { FactoryBot.create_list :post, 5, :with_ratings, ip: 'smth' }

  context 'GET #ip_list' do
    it do
      get :ip_list
      expect(response).to have_http_status(:ok)
    end
  end
end
