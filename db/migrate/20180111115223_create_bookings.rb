class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
    	t.references :user, index: true, foreign_key: true
    	t.references :theater, index: true, foreign_key: true
    	t.references :show_time, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
