class AddConfirmedToCoach < ActiveRecord::Migration[6.0]
  def change
    add_column :coaches, :confirmed, :boolean
    add_column :coaches, :confirmation_token, :string
  end
end
