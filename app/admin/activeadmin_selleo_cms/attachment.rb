ActiveAdmin.register ActiveadminSelleoCms::Attachment, as: 'Attachment' do
  menu false

  form :partial => "form"

  controller do
    respond_to :html, :js

    before_filter :set_styles, only: [:create, :update]

    private

    def set_styles
      params[:attachment][:cover] = params[:attachment].delete :cover
    end

    public

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
