module ActiveadminSelleoCms
  class Form < ActiveRecord::Base
    PDF_PATH = Rails.root.join('public','system','pdf')

    has_many :questions, class_name: "FormQuestion", :order => "position"
    has_many :answers, through: :questions

    validates :title, presence: true
    validates :email, presence: true

    attr_protected :id

    def delivery_emails(form_uuid)
      [(email || ActionMailer::Base.default[:to])] +
        answers.joins(:form_question).
            where(:activeadmin_selleo_cms_form_questions => {:question_type => FormQuestion::TYPE_EMAIL}).
            where("value IS NOT NULL AND value <> ''").where(:form_uuid => form_uuid).map(&:value)
    end
  end
end