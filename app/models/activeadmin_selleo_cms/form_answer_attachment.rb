module ActiveadminSelleoCms
  class ActiveadminSelleoCms::FormAnswerAttachment < ActiveRecord::Base
    attr_accessible :form_answer_id, :data

    has_attached_file :data,
                      :url  => "/system/cms/form_answer_attachments/:id/:style_:basename.:extension",
                      :path => ":rails_root/public/system/cms/form_answer_attachments/:id/:style_:basename.:extension"

    belongs_to :form_answer
  end
end
