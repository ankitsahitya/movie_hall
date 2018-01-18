class ShowTimesController < ApplicationController
	skip_before_action :verify_authenticity_token
	def new
		@showTime = ShowTime.new
		respond_to do |format|
			format.json { render json: {show_time: @showTime}, status: :ok }
		end
	end

	def show
		begin
			@showTime = ShowTime.find(params[:id])
			respond_to do |format|
				format.json { render json: {show_time:@showTime}, status: :ok }
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :not_found}
			end
		end
	end

	def create
		begin
			@showTime = ShowTime.new(show_time_params)
			respond_to do |format|
				if @showTime.save
					format.json { render json: { show_time: @showTime}, status: :created }
				else
					format.json { render json: @showTime.errors, status: :unprocessable_entity }
				end
			end
		rescue ActiveRecord::InvalidForeignKey => e
			respond_to do |format|
				format.json { render json: {error:'Invalid Foreign Key'}, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		begin
			@showTime = ShowTime.find(params[:id])
			respond_to do |format|
			  @showTime.destroy
				format.json { render json: {}, status: :ok }
			end  
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :unprocessable_entity }
			end
		end
	end

	def index
		@showTimes = ShowTime.all
		respond_to do |format|
			format.json { render json: {show_times:@showTimes}, status: :ok }
		end
	end

	def edit
		begin
			@showTime = ShowTime.find(params[:id])
			respond_to do |format|
				format.json { render json: {show_time:@showTime}, status: :ok }
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :not_found }
			end
		end
	end

	def update
		begin
			@showTime = ShowTime.find(params[:id])
			respond_to do |format|
				if @showTime.update(show_time_params)
					format.json { render json: {show_time:@showTime}, status: :ok }
				else
					format.json { render json: @showTime.errors, status: :unprocessable_entity }
				end
			end
		rescue => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :unprocessable_entity }
			end
		end
	end

	private
	def show_time_params
		params.require(:show_time).permit(:movie_id, :audi_id, :time_of_show, :date_of_show)
	end
end
