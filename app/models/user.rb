class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  attachment :profile_image
  
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  # ====================自分がフォローしているユーザーとの関連 ============================
  # フォローする側のUserから見て、フォローされる側のUserを(中間テーブルを介して)集める。なので親はfollowing_id(フォローする側)
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower
  # ====================自分がフォローされるユーザーとの関連 ==============================
  # フォローされる側のUserから見て、フォローしてくる側のUserを(中間テーブルを介して)集める。なので親はfollower_id(フォローされる側)
  has_many :passive_relasionships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relasionships, source: :following
  
  def followed_by?(user)
    # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)が、
    # フォローされているユーザー(つまりpassive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
    passive_relasionships.find_by(following_id: user.id).present?
  end
  
  # ================ 検索機能 ================ 
  def self.search(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?", "#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?", "%#{word}")
    elsif search == "partial_march"
      @user = User.where("name LIKE?", "%#{word}%")
    else
      @user = User.all
    end
  end
  # ================ 検索機能 ================ 
  
  
  
  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
end
