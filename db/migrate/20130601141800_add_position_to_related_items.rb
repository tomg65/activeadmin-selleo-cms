class AddPositionToRelatedItems < ActiveRecord::Migration
  def self.up
    add_column :activeadmin_selleo_cms_related_items, :position, :integer
  end

  def self.down
    remove_column :activeadmin_selleo_cms_related_items, :position
  end
end
