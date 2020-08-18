class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.float :price
      t.string :status
      t.string :category
      t.string :charity
      t.string :charity_url
      t.string :charity_score_image
      t.string :image
      t.integer :auction_length
      t.datetime :auction_end
      t.timestamps
    end
  end
end
