class Booking < ActiveRecord::Base
	belongs_to :user
	belongs_to :theater
	belongs_to :show_time
	has_many :tickets, dependent: :destroy
	validates :user_id, :theater_id, :show_time_id, presence: true
end
