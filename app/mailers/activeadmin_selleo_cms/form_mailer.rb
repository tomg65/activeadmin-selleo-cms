module ActiveadminSelleoCms
  class FormMailer < ActionMailer::Base
    default from: "web-form@jips.org"

    def form_submission(form, form_uuid)
      @form = form
      @form_uuid = form_uuid
      mail(to: 'aossowski@gmail.com', subject: "New form submission")
    end
  end
end
