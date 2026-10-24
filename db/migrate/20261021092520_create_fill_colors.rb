class CreateFillColors < ActiveRecord::Migration[8.1]
  def change
    create_table :fill_colors do |t|
      t.references :fill, null: false, foreign_key: true
      t.references :color, null: false, foreign_key: true
      t.integer :alpha, default: 100
      t.integer :stop

      t.timestamps
    end
  end
end
