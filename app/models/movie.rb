class Movie < ActiveRecord::Base
  
  mount_uploader :image, ImageUploader

  has_many :reviews

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :poster_image_url,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_future

   def review_average
    if reviews.any?
      reviews.sum(:rating_out_of_ten)/reviews.size
    end
  end

  def self.search(search)
    if search
      # if !search title.empty?&& !searchc director.empty?
      #   Movie.where("title LIKE ? OR director LIKE ?","%#{search[:title]}%","%#{search[:director]}%" )
      # elsif title
      #   Movie.where("title LIKE ?", "%#{search[:title]}%")
      # else # dirctore present
      #   Movie.where("director LIKE ?", "%#{search[:director]}%")
      # end

      if search[:title] && search[:director].empty?
        movies = Movie.where("title LIKE ?", "%#{search[:title]}%")
      elsif search[:title].empty? && search[:director]
        movies = Movie.where("director LIKE ?", "%#{search[:director]}%")
      else
        movies = Movie.where("title LIKE ? OR director LIKE ?","%#{search[:title]}%","%#{search[:director]}%" )
      end      
      # if search[:duration] != "0"
      #   result=[]
      #   binding.pry
      #   movies.each do |movie|
      #     if search[:duration] == "1" && movie.runtime_in_minutes < 90
      #       result << movie
      #     elsif search[:duration] == "3" && movie.runtime_in_minutes > 120
      #       result << movie
      #     elsif movie.runtime_in_minutes >= 90 && movie.runtime_in_minutes <= 120
      #       result << movie
      #     end
      #   end
      #   result.first
      # end
    else
      all
    end
  end

  protected
 
  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

end