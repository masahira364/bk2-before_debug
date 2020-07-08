class Book < ApplicationRecord
	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	def Book.search(search, user_or_book, how_search)
    if user_or_book == "2"
    	if how_search == "match"
      		Book.where(['title LIKE ?', "#{search}"])
	  	elsif how_search == "forward"
	  		Book.where(['title LIKE ?', "#{search}%"])
	  	elsif how_search == "backward"
	  		Book.where(['title LIKE ?', "%#{search}"])
	  	elsif how_search == "partical"
	  		Book.where(['title LIKE ?', "%#{search}%"])
	    else
	      Book.all
	    end
	end
  end
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
