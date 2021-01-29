class AddSecretToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :code, :string, default: "motobro24"
  end
end
