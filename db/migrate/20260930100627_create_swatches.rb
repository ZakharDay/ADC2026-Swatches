class CreateSwatches < ActiveRecord::Migration[8.1]
  def change
    create_table :swatches do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
