class CmsController < ApplicationController

  before_filter do
    @available_locales = ActiveadminSelleoCms::Locale.enabled
    set_locale(params[:locale])
  end

  def set_locale(locale_code)
    I18n.locale = @available_locales.map(&:code).include?(locale_code.to_s.to_sym) ? locale_code : I18n.default_locale
  end

end
