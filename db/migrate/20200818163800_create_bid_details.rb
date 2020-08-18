class CreateBidDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :bid_details do |t|
      t.references :bid, null: false, foreign_key: true
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :receipt
      t.timestamps
    end
  end
end
