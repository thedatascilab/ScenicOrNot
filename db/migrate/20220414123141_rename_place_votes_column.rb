class RenamePlaceVotesColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :places, :votes, :vote_count
  end
end
