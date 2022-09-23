# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::RatingsController, type: :controller do
  let(:post_record) { FactoryBot.create :post }
  let(:user) { FactoryBot.create :user }
  let(:value) { rand(1..5) }
  let(:user_id) { user.id }
  let(:post_id) { post_record.id }
  let(:params) { { user_id: user_id, post_id: post_id, value: value } }

  describe 'POST #create' do
    context 'when rating is created succesuflly' do
      it do
        post :create, params: params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when rating is created faulty' do
      let(:value) { nil }
      it do
        post :create, params: params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when user was not found' do
      let(:user_id) { nil }
      it do
        post :create, params: params
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when post was not found' do
      let(:post_id) { 10 }
      it do
        post :create, params: params
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
