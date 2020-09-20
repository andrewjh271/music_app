class AddActivationColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :activated, :boolean, null: false, default: false
    add_column :users, :activation_token, :string

    User.all.each do |user|
      user.update(activation_token: SecureRandom.urlsafe_base64)
    end

    change_column_null :users, :activation_token, false

  end
end
