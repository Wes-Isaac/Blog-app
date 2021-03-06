class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  validates :text, presence: true, length: { in: 1...100 }

  # after_save :update_comments_counter

  # private

  def update_comments_counter
    post.increment!(:comments_counter)
  end
end
