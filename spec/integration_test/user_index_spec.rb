require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  describe 'User Index requirements' do
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

      visit new_user_session_path
      fill_in 'user_email', with: 'test2@yahoo.com'
      fill_in 'user_password', with: '222222'
      click_button 'Log in'
      visit root_path
    end

    it 'Log In to the root page and see user name' do
      users = User.all
      users.each do |user|
        expect(page).to have_content(user.name)
      end
    end

    it 'Log In to the root page and see allpictures' do
      user_img = page.all('img')
      users = User.all
      expect(user_img.length).to eql(users.length)
    end

    it 'Log In to the root page and see user post counter' do
      users = User.all
      users.each do |user|
        expect(page).to have_content(user.posts_counter)
      end
    end

    it 'Log In to the root page and click on a user' do
      users = User.all
      user_name = users[0].name
      user_id = users[0].id
      click_link user_name
      expect(page).to have_current_path user_path(user_id)
    end
  end
end
