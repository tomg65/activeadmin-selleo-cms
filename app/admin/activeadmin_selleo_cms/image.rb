ActiveAdmin.register ActiveadminSelleoCms::Image, as: 'Image' do
  menu false

  form :partial => "form"

  controller do
    respond_to :html, :js

    def edit
      super do |format|
        format.html { render action: :edit, layout: false }
      end
    end

    def new
      super do |format|
        format.html { render action: :new, layout: false }
      end
    end

  end

end
