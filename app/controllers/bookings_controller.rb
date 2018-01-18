class BookingsController < ApplicationController
	skip_before_action :verify_authenticity_token
	def new
		@booking = Booking.new
		respond_to do |format|
			format.json { render json: {booking: @booking}, status: :ok }
		end
	end

	def show
		begin
			@booking = Booking.find(params[:id])
			respond_to do |format|
				format.json { render json: {booking:@booking}, status: :ok }
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :not_found}
			end
		end
	end

	def create
		begin
			@booking = Booking.new(booking_params)
			respond_to do |format|
				if @booking.save
					format.json { render json: { booking: @booking}, status: :created }
				else
					format.json { render json: @booking.errors, status: :unprocessable_entity }
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
			@booking = Booking.find(params[:id])
			respond_to do |format|
			  @booking.destroy
				format.json { render json: {}, status: :ok }
			end  
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :unprocessable_entity }
			end
		end
	end

	def index
		@bookings = Booking.all
		respond_to do |format|
			format.json { render json: {bookings:@bookings}, status: :ok }
		end
	end

	def edit
		begin
			@booking = Booking.find(params[:id])
			respond_to do |format|
				format.json { render json: {booking:@booking}, status: :ok }
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :not_found }
			end
		end
	end

	def update
		begin
			@booking = Booking.find(params[:id])
			respond_to do |format|
				if @booking.update(booking_params)
					format.json { render json: {booking:@booking}, status: :ok }
				else
					format.json { render json: @booking.errors, status: :unprocessable_entity }
				end
			end
		rescue => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :unprocessable_entity }
			end
		end
	end

	private
	def booking_params
		params.require(:booking).permit(:user_id, :theater_id, :show_time_id)
	end
end
