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
    if params[:asset]
      _collection = resource.assets
      _hash = params[:asset]
    elsif params[:related_item]
      _collection = resource.related_items
      _hash = params[:related_item]
    else
      _collection = []
      _hash = {}
    end

    _collection.each do |sortable|
      sortable.position = _hash.index(sortable.id.to_s) + 1
      sortable.save
    end

    render nothing: true
  end
end
