class AddColumnToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :api_key, :string, unique: true
  end
end
