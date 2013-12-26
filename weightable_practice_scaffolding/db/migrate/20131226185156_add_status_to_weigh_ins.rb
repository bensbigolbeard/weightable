class AddStatusToWeighIns < ActiveRecord::Migration
  def change
    add_column :weigh_ins, :status, :text
    add_column :weigh_ins, :date, :datetime
  end
end
