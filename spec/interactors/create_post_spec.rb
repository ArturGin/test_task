# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreatePost, type: :interactor do
  let(:title) { 'epic title' }
  let(:body) { 'radical body' }
  let(:ip) { 'hidden ip' }
  let(:login) { 'smth' }
  let!(:user) { FactoryBot.create :user, login: login }
  let(:params) { { title: title, body: body, login: 'xXCoolGamerXx', ip: ip } }
  let(:result) { CreatePost.call(params) }
  let(:passes_baseline) do
    expect(result).to be_a_success
    expect(result.post).to be_present
    expect(result.post.include_user).to be_truthy
    expect(result.user).to be_present
  end

  describe '#call' do
    context 'when all params are present' do
      context 'and user already exists' do
        let(:login) { 'xXCoolGamerXx' }
        it do
          passes_baseline
          expect(User.all.count).to eq(1)
        end
      end

      context 'and user is created' do
        let(:login) { 'xXAlsoCoolGamerXx' }
        it do
          passes_baseline
          expect(User.all.count).to eq(2)
        end
      end
    end

    context 'when params are missing' do
      let(:ip) { '' }
      it { expect(result).to be_a_failure }
    end
  end
end
