class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email, unique: true, null: false, index: { unique: true }
      t.string :nickname, unique: true, null: false, index: { unique: true }
      t.string :type, null: false

      t.string :encrypted_password, null: false, default: ""

      t.timestamps
    end
  end
end
