class TicketsController < ApplicationController
	skip_before_action :verify_authenticity_token
	def new
		@ticket = Ticket.new
		respond_to do |format|
			format.json { render json: {ticket: @ticket}, status: :ok }
		end
	end

	def show
		begin
			@ticket = Ticket.find(params[:id])
			respond_to do |format|
				format.json { render json: {ticket:@ticket}, status: :ok }
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :not_found}
			end
		end
	end

	def create
		begin
			@ticket = Ticket.new(ticket_params)
			respond_to do |format|
				if @ticket.save
					format.json { render json: { ticket: @ticket}, status: :created }
				else
					format.json { render json: @ticket.errors, status: :unprocessable_entity }
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
			@ticket = Ticket.find(params[:id])
			respond_to do |format|
				@ticket.destroy
				format.json { render json: {}, status: :ok }
			end  
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :unprocessable_entity }
			end
		end
	end

	def index
		@tickets = Ticket.all
		respond_to do |format|
			format.json { render json: {tickets:@tickets}, status: :ok }
		end
	end

	def edit
		begin
			@ticket = Ticket.find(params[:id])
			respond_to do |format|
				format.json { render json: {ticket:@ticket}, status: :ok }
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :not_found }
			end
		end
	end

	def update
		begin
			@ticket = Ticket.find(params[:id])
			respond_to do |format|
				if @ticket.update(ticket_params)
					format.json { render json: {ticket:@ticket}, status: :ok }
				else
					format.json { render json: @ticket.errors, status: :unprocessable_entity }
				end
			end
		rescue => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :unprocessable_entity }
			end
		end
	end

	private
	def ticket_params
		params.require(:ticket).permit(:audi_id,:booking_id, :type_of_seat, :seat_no, :price)
	end
end
