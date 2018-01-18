class ShowTime < ActiveRecord::Base
	belongs_to :movie
	belongs_to :audi
	has_many :bookings, dependent: :destroy
	validates :time_of_show, :date_of_show, :movie_id, :audi_id, presence: true
end
