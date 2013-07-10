module ActiveadminSelleoCms
  class Form < ActiveRecord::Base
    PDF_PATH = Rails.root.join('public','system','pdf')

    has_many :questions, class_name: "FormQuestion", :order => "position"

    validates :title, presence: true

    attr_protected :id
  end
end