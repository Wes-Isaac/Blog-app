require 'rails_helper'

RSpec.describe 'User Show page', type: :feature do
  describe 'User Show requirements' do
    before(:each) do
      User.create(
        name: 'test',
        id: 1,
        email: 'test@yahoo.com',
        password: '111111',
        confirmed_at: Time.now,
        photo: '6087-9404984.png'
      )

      User.create(
        name: 'test2',
        id: 2,
        email: 'test2@yahoo.com',
        password: '222222',
        confirmed_at: Time.now,
        photo: '6087-9404984.png'
      )

      users = User.all
      user_name = users[0].name
      user_id = users[0].id
      6.times do |_post|
        Post.create(author: users[0], title: 'testing', text: 'just testing', likes_counter: 0, comments_counter: 0)
      end
      visit new_user_session_path
      fill_in 'user_email', with: 'test2@yahoo.com'
      fill_in 'user_password', with: '222222'
      click_button 'Log in'
      visit root_path
      click_link user_name
      visit user_path(user_id)
    end

    it 'Log In, click on a user and see user image' do
      users_img = page.all('img')
      expect(users_img.length).to eql(1)
    end

    it 'Log In, click on a user and see user name' do
      users = User.all
      user_name = users[0].name
      expect(page).to have_content(user_name)
    end

    it 'Log In, click on a user and see number of user posts' do
      users = User.all
      user = users[0]
      expect(page).to have_content(user.posts_counter)
    end

    it 'Log In, click on a user and see first 3 posts' do
      users = User.all
      user = users[0]
      recent_post = user.recent_posts
      recent_post.each do |post|
        expect(page).to have_content(post.title)
      end
    end

    it 'Log In, click on a user and see link to view all posts' do
      expect(page).to have_content('See all posts')
    end

    it 'Log In, click on a user and see link to view all posts' do
      expect(page).to have_content('See all posts')
    end

    it 'Log In, click on a user and click on link to view all posts' do
      users = User.all
      click_link 'See all posts'
      expect(page).to have_current_path user_posts_path(users[0].id)
    end
  end
end
