class CreateConditions < ActiveRecord::Migration[7.0]
  def change
    create_table :prefectures do |t|

      t.timestamps
    end
  end
end