class AddDetailsToCoaches < ActiveRecord::Migration[6.0]
  def change
    add_column :coaches, :photo, :boolean
    add_column :coaches, :phone_number, :string
  end
end
