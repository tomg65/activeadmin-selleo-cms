ActiveAdmin.register ActiveadminSelleoCms::Form, as: 'Form' do
  config.batch_actions = false
  config.filters = false
  actions :all, except: [:create]

  form :partial => "form"

  index do
    column :title
    default_actions
  end

  controller do
    respond_to :html, :json

    def new
      @form = ActiveadminSelleoCms::Form.create(title: "Change me! :)")
      flash[:notice] = "New form has been created! Please change title and add some fields."
      redirect_to edit_admin_form_path(@form)
    end

    def update
      update! do |success, failure|
        success.html { redirect_to edit_admin_form_path(@form) }
        failure.html { render action: :edit }
      end
    end

  end

end
