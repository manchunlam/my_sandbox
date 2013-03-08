class AddClientIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :field_id, :integer, :default => nil
  end
end
