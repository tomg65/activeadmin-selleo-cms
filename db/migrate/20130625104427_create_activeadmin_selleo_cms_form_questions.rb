class CreateActiveadminSelleoCmsFormQuestions < ActiveRecord::Migration
  def change
    create_table :activeadmin_selleo_cms_form_questions do |t|
      t.integer :form_id
      t.string :title
      t.string :hint
      t.integer :question_type
      t.integer :position
      t.boolean :is_required, default: false
      t.boolean :is_multi, default: false
      t.boolean :has_other_option, default: false
    end
    add_index :activeadmin_selleo_cms_form_questions, :form_id, name: 'form_id_index'
  end
end
