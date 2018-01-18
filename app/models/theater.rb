class Theater < ActiveRecord::Base
	has_many :audis, dependent: :destroy
	has_many :bookings, dependent: :destroy
	validates :name, :address, :phone_no, presence: true
	validates :phone_no, length: { in: 10..15 }, numericality: { only_integer: true }
end
