class DomainBasedLocale
  def self.matches?(request)
    if !request.env["REQUEST_PATH"].match(/\/\w{2}\//) and
        locale = ActiveadminSelleoCms::Locale.enabled.with_domain.detect{ |locale| locale.domain.match(/#{request.env['SERVER_NAME']}/) }
      request.env[:locale] = locale.code
    end
  end
end