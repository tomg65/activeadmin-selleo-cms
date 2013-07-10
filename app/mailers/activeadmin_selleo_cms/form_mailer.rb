module ActiveadminSelleoCms
  class FormMailer < ActionMailer::Base
    def form_submission(form, form_uuid)
      @form = form
      @form_uuid = form_uuid
      mail(subject: "New form submission")
    end
  end
end
