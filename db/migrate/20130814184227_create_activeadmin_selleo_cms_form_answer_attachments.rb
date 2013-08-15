class CreateActiveadminSelleoCmsFormAnswerAttachments < ActiveRecord::Migration
  def change
    create_table :activeadmin_selleo_cms_form_answer_attachments do |t|
      t.belongs_to :form_answer
      t.attachment :data
      t.timestamps
    end
  end
end
