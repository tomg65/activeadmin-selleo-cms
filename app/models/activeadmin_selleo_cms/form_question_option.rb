module ActiveadminSelleoCms
  class FormQuestionOption < ActiveRecord::Base

    belongs_to :question, class_name: "FormQuestion", foreign_key: :form_question_id

    validates :title, presence: true, uniqueness: { scope: :form_question_id }

    attr_accessor :temp_id
    attr_accessible :title, :temp_id

    def options
      if question.question_type == FormQuestion::TYPE_SELECT and question.is_required
        {
          required: true
        }
      else
        {}
      end
    end

    def label
      title
    end

  end
end