class CmsController < ApplicationController

  before_filter do
    @available_locales = ActiveadminSelleoCms::Locale.enabled
    @available_locales.each do |locale|
      I18n.fallbacks[locale.code.to_sym] = [ locale.code.to_sym ]
      I18n.fallbacks[locale.code.to_sym] << I18n.default_locale unless locale.code.to_sym.eql? I18n.default_locale
    end
    set_locale(request.env[:locale] || params[:locale])
  end

  def set_locale(locale_code)
    I18n.locale = @available_locales.map(&:code).include?(locale_code.to_s.to_sym) ? locale_code : I18n.default_locale
  end

end
