class User < ActiveRecord::Base
	has_many :bookings, dependent: :destroy
	validates :name, :age, :phone_no, presence: true
	validates :phone_no, length: { in: 10..15 }
	validates :age, numericality: { only_integer: true }
end
