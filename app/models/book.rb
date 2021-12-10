class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :favorited_users, through: :favorites, source: :user
	has_many :book_comments, dependent: :destroy

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	def self.sort(switch)
	  if switch == 'likes'
	    Favorite.group(:book_id).order(Arel.sql('count(book_id) desc')).pluck(:book_id)
	  elsif switch == 'old'
	    Book.all.order(created_at: :ASC)
	  else
	    Book.all.order(created_at: :DESC)
	  end
	end


	def self.search(search,word)
    if search == "forward"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "perfect"
      @book = Book.where(title: word)
    elsif search == "partial"
    	@book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end

  is_impressionable counter_cache: true

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
