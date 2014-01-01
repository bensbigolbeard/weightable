class AddGoalDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :goal_date, :date
  end
end
