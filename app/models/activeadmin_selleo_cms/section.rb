module ActiveadminSelleoCms
  class Section < ActiveRecord::Base
    include ContentTranslation

    translates :body, fallbacks_for_empty_translations: true

    attr_protected :id

    belongs_to :sectionable, polymorphic: true

    delegate :layout, to: :sectionable

    accepts_nested_attributes_for :translations

    validates_presence_of :name
    validates_uniqueness_of :name, scope: [:sectionable_type, :sectionable_id]
    validates_associated :translations

    scope :with_name, ->(section_name) { where(name: section_name) }
    scope :blurbs, where("name ILIKE 'blurb.%'")
    scope :help, where("name ILIKE 'help.%'")

    def toolbar
      case name
        when /blurb\./ then "Easy"
        when /help\./ then "Lite"
        else "Easy"
      end
    end

    def image
      @image ||= if current_translation = translations.with_locales(I18n.fallbacks[I18n.locale]).order_by_locales(I18n.fallbacks[I18n.locale]).detect{|t| t.image}
        current_translation.image
      else
        nil
      end
    end

    def attachment
      @attachment ||= if current_translation = translations.with_locales(I18n.fallbacks[I18n.locale]).order_by_locales(I18n.fallbacks[I18n.locale]).detect{|t| t.attachment}
        current_translation.attachment
      else
        nil
      end
    end

    def images
      @images ||= if current_translation = translations.with_locales(I18n.fallbacks[I18n.locale]).order_by_locales(I18n.fallbacks[I18n.locale]).detect{|t| t.images.any? }
        current_translation.images
      else
        []
      end
    end

    def attachments
      @images ||= if current_translation = translations.with_locales(I18n.fallbacks[I18n.locale]).order_by_locales(I18n.fallbacks[I18n.locale]).detect{|t| t.attachments.any? }
        current_translation.attachments
      else
        []
      end
    end

    def to_s
      section_definition = sectionable.layout.find_section(name) if sectionable and sectionable.respond_to? :layout
      if section_definition
        if section_definition.text?
          body.to_s.html_safe
        elsif section_definition.image?
          image ? image.url : ""
        end
      end
    end

    def layout_section
      @layout_section ||= layout ? layout.find_section(name) : nil
    end

    def method_missing(sym, *args)
      if layout_section and layout_section.respond_to? sym
        layout_section.send(sym)
      else
        super
      end
    end

    def section_definition
      @section_definition ||= if sectionable and sectionable.respond_to? :layout
        sectionable.layout.find_section(name)
      end
    end

    class Translation
      attr_protected :id

      belongs_to :activeadmin_selleo_cms_section, class_name: 'ActiveadminSelleoCms::Section'

      has_many :assets, as: :assetable, dependent: :destroy
      has_many :attachments, as: :assetable, dependent: :destroy, order: 'position ASC'
      has_many :images, as: :assetable, dependent: :destroy, order: 'position ASC'
      has_one :attachment, as: :assetable, dependent: :destroy
      has_one :image, as: :assetable, dependent: :destroy
      has_many :related_items, as: :relatable, dependent: :destroy, order: 'position ASC'

      accepts_nested_attributes_for :attachments, reject_if: lambda{ |a| a[:data].blank? }
      accepts_nested_attributes_for :attachment, reject_if: lambda{ |a| a[:data].blank? }
      accepts_nested_attributes_for :image, reject_if: lambda{ |i| i[:data].blank? and i[:caption].blank? }
      accepts_nested_attributes_for :images, reject_if: lambda{ |i| i[:data].blank? }
      accepts_nested_attributes_for :related_items, reject_if: lambda{ |ri| ri[:related_url].blank? and ri[:page_id].blank? }

      scope :order_by_locales, ->(locales){ order("position(locale in ('#{locales.join}')::varchar)") }

      def to_s
        body.to_s.html_safe
      end
    end
  end
end
