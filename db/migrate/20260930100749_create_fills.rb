class CreateFills < ActiveRecord::Migration[8.1]
  def change
    create_table :fills do |t|
      t.references :user, null: false, foreign_key: true
      t.references :swatch, foreign_key: true
      t.string :color

      t.timestamps
    end
  end
end
