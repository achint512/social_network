require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    User.delete_all
    Post.delete_all
  end

  let!(:user1) { FactoryBot.create(:user, username: 'test1', email: 'test1@gmail.com') }
  let!(:user2) { FactoryBot.create(:user, username: 'test2', email: 'test2@gmail.com') }
  let!(:user3) { FactoryBot.create(:user, username: 'test3', email: 'test3@gmail.com') }

  describe '#index' do
    it 'returns all the users in system as array' do
      get :index, as: :json

      data = JSON.parse(response.body)
      keys = data.first.keys

      expect(response.status).to eq(200)
      expect(data.size).to eq(3)
      expect(keys.include?('username')).to be_truthy
      expect(keys.include?('email')).to be_truthy
      expect(keys.include?('uuid')).to be_falsey
    end
  end

  describe '#show' do
    let(:params) { {id: user1.uuid} }

    context 'when user1 has not followed anyone' do
      it 'returns unfollowed_usernames as collection of user2 and user3' do
        get :show, params: params, as: :json

        data = JSON.parse(response.body)['data']
        user_data = data['user']['user']

        expect(response.status).to eq(200)
        expect(user_data['username']).to eq(user1.username)
        expect(user_data['email']).to eq(user1.email)
        expect(user_data['id']).to eq(user1.uuid)
        expect(data['unfollowed_usernames'].include?([user2.username])).to be_truthy
        expect(data['unfollowed_usernames'].include?([user3.username])).to be_truthy
      end
    end

    context 'when user1 has already followed user2' do
      before do
        user1.follow_person(user2)
      end

      it 'returns unfollowed_usernames as collection of user3' do
        get :show, params: params, as: :json

        data = JSON.parse(response.body)['data']
        user_data = data['user']['user']

        expect(response.status).to eq(200)
        expect(user_data['username']).to eq(user1.username)
        expect(user_data['email']).to eq(user1.email)
        expect(user_data['id']).to eq(user1.uuid)
        expect(data['unfollowed_usernames'].include?([user2.username])).to be_falsey
        expect(data['unfollowed_usernames'].include?([user3.username])).to be_truthy
      end
    end
  end

  describe '#update' do
    let(:follow_user_params) { {user: {follow_username: user2.username}, id: user1.uuid} }

    context 'when called to follow_user' do
      it 'adds the person to the users follows and user to persons followers' do
        patch :update, params: follow_user_params, as: :json

        expect(response.status).to eq(200)
        expect(user1.follows.first).to eql(user2)
        expect(user2.followers.first).to eql(user1)
        expect(user1.posts.count).to eql(0)
      end
    end

    let(:post_description) { 'TEST post' }
    let(:create_new_post_params) do
      {user: {post_description: post_description}, id: user1.uuid}
    end

    context 'when called to create_new_post!' do
      it 'creates the post and links it to the user' do
        patch :update, params: create_new_post_params, as: :json

        expect(response.status).to eq(200)
        expect(user1.posts.first.description).to eql(post_description)
        expect(user1.follows.count).to eql(0)
        expect(user1.followers.count).to eql(0)
      end
    end
  end

  after do
    user1.destroy
    user2.destroy
    user3.destroy
  end
end
