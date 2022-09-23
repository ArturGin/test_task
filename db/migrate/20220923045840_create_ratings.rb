class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.integer :value,  null: false
      t.belongs_to :user, null: false
      t.belongs_to :post, null: false

      t.timestamps
    end
  end
end
