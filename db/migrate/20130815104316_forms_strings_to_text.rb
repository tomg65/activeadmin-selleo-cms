class FormsStringsToText < ActiveRecord::Migration
  def up
    change_column :activeadmin_selleo_cms_form_questions, :hint, :text
    change_column :activeadmin_selleo_cms_form_answers, :value, :text
  end
end
