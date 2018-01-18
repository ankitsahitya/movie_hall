class Audi < ActiveRecord::Base
	belongs_to :theater
	has_many :tickets, dependent: :destroy
	has_many :show_times, dependent: :destroy
	has_many :movies, through: :show_times
	validates :number, :theater_id, presence: true
	validates :number, numericality: { only_integer: true }
end
