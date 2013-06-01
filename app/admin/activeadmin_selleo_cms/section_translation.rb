ActiveAdmin.register ActiveadminSelleoCms::Section::Translation, as: 'SectionTranslation' do
  menu false

  form :partial => "form"

  controller do
    respond_to :html

    def edit
      super do |format|
        format.html { render action: :edit, layout: false }
      end
    end

    def create
      create! do |success, failure|
        success.html { redirect_to admin_sections_path  }
        failure.html { render action: :new  }
      end
    end

    def update
      update! do |success, failure|
        success.html { redirect_to admin_sections_path  }
        failure.html { render action: :edit  }
      end
    end

  end

  member_action :sort_assets, :method => :post do
    resource.assets.each do |asset|
      asset.position = params['asset'].index(asset.id.to_s) + 1
      asset.save
    end
    render nothing: true
  end
end
