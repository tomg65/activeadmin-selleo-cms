module ActiveadminSelleoCms
  class Form < ActiveRecord::Base
    has_many :questions, class_name: "FormQuestion", :order => "position"

    validates :title, presence: true

    attr_protected :id
  end
end