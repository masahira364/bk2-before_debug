class BookComment < ApplicationRecord
	belongs_to :user
	belongs_to :book

	validates :comment, presence:true
	validates_uniqueness_of :book_id, scope: :user_id
end
