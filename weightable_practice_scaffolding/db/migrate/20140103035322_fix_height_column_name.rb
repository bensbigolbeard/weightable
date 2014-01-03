class FixHeightColumnName < ActiveRecord::Migration
  def change
    rename_column :Users, :height, :height_in_feet
  end
end
