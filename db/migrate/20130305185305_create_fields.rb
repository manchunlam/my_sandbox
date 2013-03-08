class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.string :label
      t.text :instruction

      t.timestamps
    end
  end
end
