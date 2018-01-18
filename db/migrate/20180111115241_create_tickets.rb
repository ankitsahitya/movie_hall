class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
    	t.references :booking, index: true, foreign_key: true
    	t.references :audi, index: true, foreign_key: true
    	t.string :type_of_seat
    	t.integer :seat_no
    	t.decimal :price
      t.timestamps null: false
    end
  end
end
