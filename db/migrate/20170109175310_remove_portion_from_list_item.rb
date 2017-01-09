class RemovePortionFromListItem < ActiveRecord::Migration[5.0]
  def change
    remove_column :list_items, :portion, :integer
  end
end
