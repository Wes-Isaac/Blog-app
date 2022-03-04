require 'rails_helper'
# rubocop:disable Metrics/BlockLength

RSpec.describe 'Post Index page', type: :feature do
  describe 'Post Index requirements' do
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
      Post.create(author: users[0], title: 'testing this link', text: 'just testing', likes_counter: 0,
                  comments_counter: 0)
      6.times do |_post|
        Post.create(author: users[0], title: 'testing', text: 'just testing', likes_counter: 0, comments_counter: 0)
      end
      8.times { |_comment| Comment.create(author: users[1], text: 'just testing') }
      10.times { |_like| Like.create(author: users[1]) }
      visit new_user_session_path
      fill_in 'user_email', with: 'test2@yahoo.com'
      fill_in 'user_password', with: '222222'
      click_button 'Log in'
      visit root_path
      click_link user_name
      visit user_path(user_id)
      click_link 'See all posts'
      visit user_posts_path(user_id)
    end

    it 'Log In, click on the first user, click on all posts and see user image' do
      users_img = page.all('img')
      expect(users_img.length).to eql(1)
    end

    it 'Log In, click on the first user, click on all posts and see user name' do
      users = User.all
      user_name = users[0].name
      expect(page).to have_content(user_name)
    end

    it 'Log In, click on the first user, click on all posts and see user posts count' do
      users = User.all
      user = users[0]
      expect(page).to have_content(user.posts_counter)
    end

    it 'Log In, click on the first user, click on all posts and see all usesr posts title' do
      users = User.all
      user = users[0]
      posts = user.posts
      posts.each do |post|
        expect(page).to have_content(post.title)
      end
    end

    it 'Log In, click on the first user, click on all posts and see all users posts text' do
      users = User.all
      user = users[0]
      posts = user.posts
      posts.each do |post|
        expect(page).to have_content(post.text)
      end
    end

    it 'Log In, click on the first user, click on all posts and see first 5 comments of users posts' do
      users = User.all
      user = users[0]
      posts = user.posts
      posts.each do |post|
        post.recent_comments.each do |comment|
          expect(page).to have_content(comment.text)
        end
      end
    end

    it 'Log In, click on the first user, click on all posts and see all comments count on each post' do
      users = User.all
      user = users[0]
      posts = user.posts
      posts.each do |post|
        expect(page).to have_content(post.comments_counter)
      end
    end

    it 'Log In, click on the first user, click on all posts and see all likes count on each post' do
      users = User.all
      user = users[0]
      posts = user.posts
      posts.each do |post|
        expect(page).to have_content(post.likes_counter)
      end
    end

    it 'Log In, click on the first user, click on all posts and see all likes count on each post' do
      users = User.all
      user = users[0]
      selected_post = Post.find_by(title: 'testing this link')
      selected_post_name = selected_post.title
      click_link selected_post_name
      expect(page).to have_current_path user_post_path(user.id, selected_post.id)
    end
  end
end

# rubocop:enable Metrics/BlockLength
