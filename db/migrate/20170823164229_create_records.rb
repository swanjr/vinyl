class CreateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :records do |t|
      t.string :title, null: false, index: true
      t.string :condition, null: false 
    end
  end
end
