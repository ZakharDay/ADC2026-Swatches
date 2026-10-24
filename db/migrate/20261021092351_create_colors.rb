class CreateColors < ActiveRecord::Migration[8.1]
  def change
    create_table :colors do |t|
      t.references :user, null: false, foreign_key: true
      t.string :rgb_hash

      t.timestamps
    end
  end
end
