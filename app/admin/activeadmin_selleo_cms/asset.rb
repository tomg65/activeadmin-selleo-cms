ActiveAdmin.register ActiveadminSelleoCms::Asset, { as: 'Asset' } do
  config.batch_actions = false
  menu false

  controller do
    respond_to :html, :js
  end

end
