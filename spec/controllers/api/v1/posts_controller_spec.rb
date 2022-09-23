# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  let!(:posts) { FactoryBot.create_list :post, 5, :with_ratings }
  let(:params) { { login: 'smth', title: 'smth', ip: 'smth', body: 'smth' } }
  let!(:create_post) do
    allow(CreatePost).to receive(:call) do
      double('Interactor::Context', success?: success, post: posts.first, error: error)
    end
  end

  context 'GET #index' do
    it 'when average true' do
      get :index, params: { average: true }
      expect(response).to have_http_status(:ok)
      expect(parsed_body).not_to be_blank
    end

    it 'when page and limit are present' do
      get :index, params: { limit: 2 }
      expect(response).to have_http_status(:ok)
      expect(parsed_body.count).to eq(2)
    end
  end

  context 'POST #create' do
    let(:success) { true }
    let(:error) { nil }
    context 'when post created successfully' do
      it do
        post :create, params: params
        expect(parsed_body).not_to be_blank
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when post creation failed' do
      let(:success) { false }
      let(:error) { 'Smth went horrible' }
      it do
        post :create, params: params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_body['error']).to eq(error)
      end
    end
  end
end
