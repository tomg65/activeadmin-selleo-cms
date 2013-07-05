class CreateActiveadminSelleoCmsFormQuestionOptions < ActiveRecord::Migration
  def change
    create_table :activeadmin_selleo_cms_form_question_options do |t|
      t.integer :form_question_id
      t.string :title
      t.integer :position
    end
    add_index :activeadmin_selleo_cms_form_question_options, :form_question_id, name: 'form_question_id_index'
  end
end