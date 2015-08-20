
class MoviesController < ApplicationController
  
  # before_action :must_be_logged_in
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    if current_user
      @movie = Movie.new
    else
      redirect_to new_session_path, notice: "Please sign in first"
    end
  end

  def edit
    if current_user
      @movie = Movie.find(params[:id])
    else
      redirect_to new_session_path, notice: "Please sign in first"
    end
  end

  def create
    @movie = Movie.new(movie_params)
    binding.pry
    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    if current_user
      @movie = Movie.find(params[:id])

      if @movie.update_attributes(movie_params)
        redirect_to movie_path(@movie)
      else
        render :edit
      end
    else
      redirect_to new_session_path, notice: "Please sign in first"
    end
  end

  def destroy
    if current_user
      @movie = Movie.find(params[:id])
      @movie.destroy
      redirect_to movies_path
    else
      redirect_to new_session_path, notice: "Please sign in first"
    end
  end

  protected
  
  # def must_be_logged_in
  #   unless current_user
  #     redirect_to movies_path
  #   end
  # end

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :image
    )
  end

end 
