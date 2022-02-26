require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'test for the comments mode should pass' do
    new_user = User.new(name: 'isaac', bio: 'whome', posts_counter: 2)
    new_post = Post.new(author: new_user, text: 'Nice post', comments_counter: 3, likes_counter: 5)
    subject do
      Like.new
    end

    before { subject.save }

    it 'should return 4' do
      subject.post = new_post
      subject.author = new_user
      subject.update_likes_counter
      expect(subject.post.likes_counter).to be(6)
    end
  end
end
