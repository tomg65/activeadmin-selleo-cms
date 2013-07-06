class CreateActiveadminSelleoCmsForms < ActiveRecord::Migration
  def change
    create_table :activeadmin_selleo_cms_forms do |t|
      t.string :title
    end
  end
end