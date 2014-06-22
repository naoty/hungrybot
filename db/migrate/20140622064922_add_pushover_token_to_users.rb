class AddPushoverTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pushover_token, :string
  end
end
