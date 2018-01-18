class CreateShowTimes < ActiveRecord::Migration
  def change
    create_table :show_times do |t|
    	t.references :movie,  index: true, foreign_key: true
    	t.references :audi,  index: true, foreign_key: true
    	t.time :time_of_show
    	t.date :date_of_show
      t.timestamps null: false
    end
  end
end
