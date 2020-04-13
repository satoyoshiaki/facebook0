class AddGazouToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gazou, :text
  end
end
