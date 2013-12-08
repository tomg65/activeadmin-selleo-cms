module ActiveadminSelleoCms
  class RelatedItem < ActiveRecord::Base
    attr_protected :id

    belongs_to :relatable, polymorphic: true
    belongs_to :page

    validates_presence_of :page_id, if: ->(ri){ ri.related_url.blank? }
    validates :related_url, presence: true, format: { with: /\Ahttp/i }, if: ->(ri){ ri.page_id.blank? }

    def target_title
      title.present? ? title : (page.present? ? page.title : related_url)
    end

    def target_url
      related_url.present? ? related_url : page.url
    end

  end
end
