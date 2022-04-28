class AddIndexOnActiveOnGeographToPlaces < ActiveRecord::Migration[7.0]
  def change
    add_index :places, :active_on_geograph
  end
end
