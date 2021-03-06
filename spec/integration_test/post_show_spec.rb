require 'rails_helper'

# rubocop:disable Metrics/BlockLength

RSpec.describe 'Post show page', type: :feature do
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
      selected_post = Post.find_by(title: 'testing this link')
      selected_post_name = selected_post.title
      8.times { |_comment| Comment.create(author: users[1], post: selected_post, text: 'just testing') }
      10.times { |_like| Like.create(author: users[1], post: selected_post) }
      visit new_user_session_path
      fill_in 'user_email', with: 'test2@yahoo.com'
      fill_in 'user_password', with: '222222'
      click_button 'Log in'
      visit root_path
      click_link user_name
      visit user_path(user_id)
      click_link 'See all posts'
      visit user_posts_path(user_id)
      click_link selected_post_name
      visit user_post_path(user_id, selected_post.id)
    end

    it 'Log In, click on the first user, click on all posts and clicks on selected post and see post title' do
      post = Post.find_by(title: 'testing this link')
      post_name = post.title
      expect(page).to have_content(post_name)
    end

    it 'Log In, click on the first user, click on all posts and clicks on selected post and see post author' do
      post = Post.find_by(title: 'testing this link')
      expect(page).to have_content(post.author.name)
    end

    it 'Log In, click on the first user, click on all posts
    and clicks on selected post and see number on post comments' do
      post = Post.find_by(title: 'testing this link')
      expect(page).to have_content(post.comments_counter)
    end

    it 'Log In, click on the first user, click on all posts and clicks on selected post and see number on post likes' do
      post = Post.find_by(title: 'testing this link')
      expect(page).to have_content(post.likes_counter)
    end

    it 'Log In, click on the first user, click on all posts and clicks on selected post and see number on post likes' do
      post = Post.find_by(title: 'testing this link')
      expect(page).to have_content(post.text)
    end

    it 'Log In, click on the first user, click on
    all posts and clicks on selected post and see all comments authors name' do
      post = Post.find_by(title: 'testing this link')
      post_comments = post.comments
      post_comments.each do |comment|
        expect(page).to have_content(comment.author.name)
      end
    end

    it 'Log In, click on the first user, click on all posts and clicks on selected post and see all comments text' do
      post = Post.find_by(title: 'testing this link')
      post_comments = post.comments
      post_comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
