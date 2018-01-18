class AudisController < ApplicationController
	skip_before_action :verify_authenticity_token
	def new
		@audi = Audi.new
		respond_to do |format|
			format.json { render json: {audi: @audi}, status: :ok }
		end
	end

	def show
		begin
			@audi = Audi.find(params[:id])
			respond_to do |format|
				format.json { render json: {audi:@audi}, status: :ok }
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :not_found}
			end
		end
	end

	def create
		begin
			@audi = Audi.new(audi_params)
			respond_to do |format|
				if @audi.save
					format.json { render json: { audi: @audi}, status: :created }
				else
					format.json { render json: @audi.errors, status: :unprocessable_entity }
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
			@audi = Audi.find(params[:id])
			respond_to do |format|
			  @audi.destroy
				format.json { render json: {}, status: :ok }
			end  
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :unprocessable_entity }
			end
		end
	end

	def index
		@audis = Audi.all
		respond_to do |format|
			format.json { render json: {audis:@audis}, status: :ok }
		end
	end

	def edit
		begin
			@audi = Audi.find(params[:id])
			respond_to do |format|
				format.json { render json: {audi:@audi}, status: :ok }
			end
		rescue ActiveRecord::RecordNotFound => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :not_found }
			end
		end
	end

	def update
		begin
			@audi = Audi.find(params[:id])
			respond_to do |format|
				if @audi.update(audi_params)
					format.json { render json: {audi:@audi}, status: :ok }
				else
					format.json { render json: @audi.errors, status: :unprocessable_entity }
				end
			end
		rescue => e
			respond_to do |format|
				format.json { render json: {error:e.message}, status: :unprocessable_entity }
			end
		end
	end

	private
	def audi_params
		params.require(:audi).permit(:number, :theater_id)
	end
end
