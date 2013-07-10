module ActiveadminSelleoCms
  class Image < ActiveadminSelleoCms::Asset
    attr_accessor :image_width, :image_height, :resize_method, :thumb_width, :thumb_height, :thumb_resize_method

    has_attached_file :data,
                      :url  => "/system/cms/images/:id/:style_:basename.:extension",
                      :path => ":rails_root/public/system/cms/images/:id/:style_:basename.:extension",
                      :styles => Proc.new{ |attachment| attachment.instance.image_sizes },
                      :default_style => :normal,
                      :processors => [:cropper]

    #validates_attachment_size :data, :less_than => 1.megabytes
    validates_attachment_presence :data

    attr_protected :id

    after_update :reprocess_image, :if => :cropping?

    def cropping?
      !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
    end

    def image_sizes
      {
          :normal => "#{image_width || 640}x#{image_height || 480}#{resize_method || "#"}",
          :thumb => "#{thumb_width || 160}x#{thumb_height || 120}#{thumb_resize_method || ">"}"
      }
    end

    private

    def reprocess_image
      data.assign(data)
      data.save
    end

  end
end
