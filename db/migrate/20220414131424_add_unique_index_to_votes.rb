class AddUniqueIndexToVotes < ActiveRecord::Migration[7.0]
  def change
    add_index :votes, [:place_id, :uuid], unique: true
  end
end
