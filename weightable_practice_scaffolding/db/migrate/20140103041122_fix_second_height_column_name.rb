class FixSecondHeightColumnName < ActiveRecord::Migration
  def change
    rename_column :Users, :height, :height_in_inches
  end
end
