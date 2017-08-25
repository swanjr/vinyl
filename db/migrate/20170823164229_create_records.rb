class CreateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :records do |t|
      t.string :condition, null: false 
      t.string :sides
    end
  end
end
