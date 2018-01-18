class Movie < ActiveRecord::Base
	has_many :show_times, dependent: :destroy
	has_many :audis, through: :show_times
	validates :name, :category, presence: true
	validates :category, inclusion: { in: %w(U U/A A)}
end
