class CreateWeighIns < ActiveRecord::Migration
  def change
    create_table :weigh_ins do |t|
      t.integer :weight
      t.string :pic_url
      t.integer :user_id

      t.timestamps
    end
  end
end
