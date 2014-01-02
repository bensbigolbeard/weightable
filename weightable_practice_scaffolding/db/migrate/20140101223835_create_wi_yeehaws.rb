class CreateWiYeehaws < ActiveRecord::Migration
  def change
    create_table :wi_yeehaws do |t|
      t.references :user, index: true
      t.references :weigh_in, index: true

      t.timestamps
    end
  end
end
