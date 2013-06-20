class AddDomainToLocale < ActiveRecord::Migration
  def change
    add_column :activeadmin_selleo_cms_locales, :domain, :string
  end
end
