class ChangePriceInTicket < ActiveRecord::Migration
  def change
    change_column :tickets, :price, :integer
  end
end
