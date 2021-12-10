class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :week_favorites, -> {where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'
	has_many :book_comments, dependent: :destroy

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	def self.sort(selection)
	  if selection == 'PV'
	    @books = Book.all.order(impressions_count: :DESC)
	  elsif selection == 'new'
	    @books = Book.all.order(created_at: :DESC)
	  elsif selection == 'old'
	    @books = Book.all.order(created_at: :ASC)
	  else
      @books = Book.left_joins(:week_favorites).group(:id).order(Arel.sql('count(book_id) desc'))
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
