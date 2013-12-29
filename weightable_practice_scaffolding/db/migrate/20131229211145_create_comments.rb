class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.references :weigh_in, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
