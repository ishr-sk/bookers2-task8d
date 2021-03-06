class Book < ApplicationRecord
	 belongs_to :user

	 has_many :favorites, dependent: :destroy
	 has_many :book_comments, dependent: :destroy

	 def favorited_by?(user)
	 	favorites.where(user_id: user.id).exists?
	 end

  # ================ 検索機能 ================
  def self.search(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?", "%#{word}")
    elsif search == "partial_march"
      @book = Book.where("title LIKE?", "%#{word}%")
    else
      @book = Book.all
    end
  end
  # ================ 検索機能 ================

  # 一覧ページを新しい順（降順）にする：desc
  # でもこれだとデフォルトの順番そのものを変えてるから全部に適応されてしまっている
  # default_scope -> {order(created_at: :desc)}
 

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
	validates :rate, presence: true

end
