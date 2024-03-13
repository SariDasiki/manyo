class AddusersTonullcolumns < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :name, false
    change_column_null :users, :email, false
    change_column_null :users, :password_digest, false
    change_column_null :users, :admin, false
    add_index :users, :email, unique: true
  end
end
