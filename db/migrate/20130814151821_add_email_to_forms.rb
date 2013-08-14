class AddEmailToForms < ActiveRecord::Migration
  def change
    add_column :activeadmin_selleo_cms_forms, :email, :string
  end
end
