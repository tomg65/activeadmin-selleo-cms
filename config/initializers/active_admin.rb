ActiveAdmin.application.tap do |config|
  config.load_paths << "#{ActiveadminSelleoCms::Engine.root}/app/admin"
  config.load_paths <<  File.expand_path('app/admin', Rails.root)

  config.before_filter :set_admin_locale
end

module ActiveAdmin
  class BaseController
    with_role :admin
  end
end
