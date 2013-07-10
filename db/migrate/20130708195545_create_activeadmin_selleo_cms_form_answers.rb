class CreateActiveadminSelleoCmsFormAnswers < ActiveRecord::Migration
  def change
    create_table :activeadmin_selleo_cms_form_answers do |t|
      t.string :form_uuid
      t.integer :form_id
      t.integer :form_question_id
      t.string :dom_id
      t.string :value
      t.attachment :data
    end
  end
end
