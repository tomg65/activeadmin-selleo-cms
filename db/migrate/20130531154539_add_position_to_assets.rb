class AddPositionToAssets < ActiveRecord::Migration
  def self.up
    add_column :activeadmin_selleo_cms_assets, :position, :integer
  end

  def self.down
    remove_column :activeadmin_selleo_cms_assets, :position
  end
end
