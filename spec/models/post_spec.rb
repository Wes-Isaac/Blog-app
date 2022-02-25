require 'rails_helper'

RSpec.describe Post, type: :model do
  new_user = User.new(name: 'isaac', bio: 'whome', posts_counter: 2)

  subject do
    Post.new
  end

  it 'should be invalid because title is nil' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'should be invalid because title charcater is more than 250' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'should be invalid because commentscounter is a float' do
    subject.comments_counter = 1.5
    expect(subject).to_not be_valid
  end

  it 'should be invalid because commentscounter is less than 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should be invalid because likescounter is a float' do
    subject.likes_counter = 1.5
    expect(subject).to_not be_valid
  end

  it 'should be invalid because likescounter is less than 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should return 3' do
    subject.title = 'another post'
    subject.text = 'i am trying to test'
    subject.author = new_user
    subject.update_posts_counter

    expect(subject.author.posts_counter).to be(3)
  end

  describe 'testing the Post class' do
    before { 10.times { |_comment| Comment.new(author: new_user, post: subject, text: 'good testing') } }
    it 'should pass the following test' do
      expect(subject.recent_comments).to eq(subject.comments.last(5))
    end
  end
end
