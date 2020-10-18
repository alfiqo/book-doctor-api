class CreateDoctors < ActiveRecord::Migration[6.0]
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :specialization
      t.references :hospital, foreign_key: true

      t.timestamps
    end
  end
end
