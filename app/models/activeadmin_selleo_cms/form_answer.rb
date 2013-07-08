module ActiveadminSelleoCms
  class FormAnswer < ActiveRecord::Base
    attr_accessible :form_uuid, :dom_id, :form_id, :form_question_id, :value
    validates_presence_of :form_uuid, :dom_id

    belongs_to :form
    belongs_to :form_question

    after_save do
      if form_question.input_type == :radio_button_tag and !dom_id.match(/_other/)
        FormAnswer.where(form_uuid: form_uuid, form_question_id: form_question_id).where("id <> ? AND dom_id NOT LIKE '%_other%'", id).destroy_all
      end
    end

  end
end