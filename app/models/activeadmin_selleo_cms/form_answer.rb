module ActiveadminSelleoCms
  class FormAnswer < ActiveRecord::Base
    attr_accessible :form_uuid, :dom_id, :form_id, :form_question_id, :value, :data
    validates_presence_of :form_uuid, :dom_id

    has_attached_file :data,
                      :url  => "/system/cms/form_answers/:id/:style_:basename.:extension",
                      :path => ":rails_root/public/system/cms/form_answers/:id/:style_:basename.:extension"

    belongs_to :form
    belongs_to :form_question

    after_save do
      if form_question.input_type == :radio_button_tag and !dom_id.match(/_other/)
        FormAnswer.where(form_uuid: form_uuid, form_question_id: form_question_id).where("id <> ? AND dom_id NOT LIKE '%_other%'", id).destroy_all
      end
    end

    def self.value_for(form_uuid, dom_id)
      if answer = self.where(form_uuid: form_uuid, dom_id: dom_id).first
        answer.value
      else
        nil
      end
    end

    def self.file_for(form_uuid, dom_id)
      if answer = self.where(form_uuid: form_uuid, dom_id: dom_id).first and answer.data.exists?
        answer
      else
        nil
      end
    end

  end
end