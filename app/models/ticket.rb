class Ticket < ActiveRecord::Base
	belongs_to :booking
	belongs_to :audi
	validates :type_of_seat, :seat_no, :booking_id, :audi_id, :price, presence: true
	validates :type_of_seat, inclusion: { in: %w(star_class prime recliner)}
  validates :price, numericality: { greater_than: 0 }
	validates :seat_no, numericality: { only_integer: true }
end
