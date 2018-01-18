class CreateAudis < ActiveRecord::Migration
  def change
    create_table :audis do |t|
    	t.references :theater,  index: true, foreign_key: true
    	t.integer :number
      t.timestamps null: false
    end
  end
end
