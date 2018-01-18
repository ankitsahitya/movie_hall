class MoviesController < ApplicationController
	skip_before_action :verify_authenticity_token
	def new
		@movie = Movie.new
		respond_to do |format|
			format.json { render json: {movie: @movie}, status: :ok }
		end
	end

	def show
		begin
			@movie = Movie.find(params[:id])
			respond_to do |format|
				format.json { render json: {movie:@movie}, status: :ok }
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :not_found}
			end
		end
	end

	def create
		@movie = Movie.new(movie_params)
		respond_to do |format|
			if @movie.save
				format.json { render json: { movie: @movie}, status: :created }
			else
				format.json { render json: @movie.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		begin
			@movie = Movie.find(params[:id])
			respond_to do |format|
			  @movie.destroy
				format.json { render json: {}, status: :ok }
			end  
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :unprocessable_entity }
			end
		end
	end

	def index
		@movies = Movie.all
		respond_to do |format|
			format.json { render json: {movies:@movies}, status: :ok }
		end
	end

	def edit
		begin
			@movie = Movie.find(params[:id])
			respond_to do |format|
				format.json { render json: {movie:@movie}, status: :ok }
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :not_found }
			end
		end
	end

	def update
		begin
			@movie = Movie.find(params[:id])
			respond_to do |format|
				if @movie.update(movie_params)
					format.json { render json: {movie:@movie}, status: :ok }
				else
					format.json { render json: @movie.errors, status: :unprocessable_entity }
				end
			end
		rescue => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :unprocessable_entity }
			end
		end
	end

	private
	def movie_params
		params.require(:movie).permit(:name, :category)
	end
end
