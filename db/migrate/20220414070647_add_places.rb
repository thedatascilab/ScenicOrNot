class AddPlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :places do |t|
      t.integer :geograph_id
      t.string :title
      t.string :description
      t.string :subject
      t.string :creator
      t.string :creator_uri
      t.datetime :date_submitted
      t.float :lat
      t.float :lon
      t.text :gridsquare
      t.string :license_uri
      t.string :format
      t.integer :votes
      t.float :random
      t.integer :width
      t.integer :height
      t.float :aspect
      t.string :image_uri
      t.string :geograph_image_uri

      t.timestamps
    end
  end
end
