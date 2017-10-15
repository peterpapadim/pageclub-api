class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.integer :user_id
      t.string :volume_id
      t.boolean :checked_out, :default => false
      t.integer :checked_out_user, :default => 0
    end
  end
end
