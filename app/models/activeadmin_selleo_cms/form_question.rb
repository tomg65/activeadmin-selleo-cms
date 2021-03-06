module ActiveadminSelleoCms
  class FormQuestion < ActiveRecord::Base

    TYPE_TEXT = 0
    TYPE_SELECT = 1
    TYPE_FILE = 2
    TYPE_LABEL = 3
    TYPE_EMAIL = 4
    TYPES = [TYPE_TEXT, TYPE_SELECT, TYPE_FILE, TYPE_LABEL, TYPE_EMAIL]
    TYPE_NAMES = ["text question", "select question", "file upload", "label", "email"]

    belongs_to :form
    has_many :options, class_name: "FormQuestionOption", :order => "position"
    has_many :answers, class_name: "FormAnswer"

    acts_as_list :scope => :form_id

    attr_accessor :order
    attr_accessible :title, :question_type, :position, :is_required, :is_multi, :has_other_option, :options_attributes, :order, :hint
    accepts_nested_attributes_for :options, allow_destroy: true

    validates :title, presence: true, uniqueness: {scope: :form_id}

    class << self

      def for_select
        TYPES.map { |type| [question_type_dictionary(type), type] }
      end

      def question_type_dictionary(int)
        TYPE_NAMES[int]
      end

    end

    def is_type?(type)
      "ActiveadminSelleoCms::FormQuestion::TYPE_#{type.upcase}".constantize == question_type
    end

    def set_options_order
      unless order.nil?
        order.split(",").each_with_index do |temp_id, index|
          options.each do |o|
            o.update_attribute(:position, index+1) if temp_id == o.temp_id
          end
        end
        order = nil
        self.save
      end
    end

    def input_type
      if question_type == TYPE_TEXT and is_multi
        :text_area_tag
      elsif question_type == TYPE_TEXT
        :text_field_tag
      elsif question_type == TYPE_SELECT and is_multi
        :check_box_tag
      elsif question_type == TYPE_SELECT
        :radio_button_tag
      elsif question_type == TYPE_FILE
        :file_field_tag
      elsif question_type == TYPE_LABEL
        :legend
      elsif question_type == TYPE_EMAIL
        :email_field_tag
      end
    end

    def collection
      if question_type == TYPE_SELECT
        {
            collection: options.map{ |o| [o.title, o.id, o.options] }
        }
      else
        {}
      end
    end

    def label
      "#{title}#{'<i>'+I18n.t("active_admin.cms.forms.required")+'</i>' if is_required}".html_safe
    end

  end

end