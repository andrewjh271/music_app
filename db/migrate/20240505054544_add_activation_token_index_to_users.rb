class AddActivationTokenIndexToUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :activation_token
  end
end
