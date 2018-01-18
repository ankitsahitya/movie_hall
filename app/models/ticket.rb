class Ticket < ActiveRecord::Base
	belongs_to :booking
	belongs_to :audi
	validates :type_of_seat, :seat_no, :booking_id, :audi_id, :price, presence: true
	validates :type_of_seat, inclusion: { in: %w(star_class prime recliner)}
	validates :seat_no, numericality: { only_integer: true }
	validates :price, numericality: { only_decimal: true }
end
