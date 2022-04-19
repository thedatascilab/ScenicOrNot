class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.belongs_to :place
      t.integer :rating
      t.uuid :uuid

      t.timestamps
    end
  end
end
