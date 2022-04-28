class AddActiveOnGeographToPlaces < ActiveRecord::Migration[7.0]
  def change
    add_column :places, :active_on_geograph, :boolean, default: true
  end
end
