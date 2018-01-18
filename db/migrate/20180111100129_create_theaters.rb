class CreateTheaters < ActiveRecord::Migration
  def change
    create_table :theaters do |t|
    	t.string :name
    	t.string :address
    	t.string :phone_no
      t.timestamps null: false
    end
  end
end
