class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  attachment :profile_image, destroy: false

  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: :following_id,
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: :follower_id,
                                   dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :following

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  def User.search(search, user_or_book, how_search)
    if user_or_book == "1"
      if how_search == "match"
        User.where(['name LIKE ?', "#{search}"])
      elsif how_search == "forward"
        User.where(['name LIKE ?', "#{search}%"])
      elsif how_search == "backward"
        User.where(['name LIKE ?', "%#{search}"])
      elsif how_search == "partical"
        User.where(['name LIKE ?', "%#{search}%"])
      else
        User.all
      end
    end
  end
  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}
end
