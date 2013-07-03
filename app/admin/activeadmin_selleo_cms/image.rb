ActiveAdmin.register ActiveadminSelleoCms::Image, as: 'Image' do
  menu false

  form :partial => "form"

  member_action :crop, :method => :get do
    @image = ActiveadminSelleoCms::Image.find(params[:id])
  end

  controller do
    respond_to :html, :js

    before_filter :set_styles, only: [:create, :update]

    private

    def set_styles
      params[:image][:data] = params[:image].delete :data if params[:image][:data]
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
