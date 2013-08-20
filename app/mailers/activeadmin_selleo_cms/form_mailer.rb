module ActiveadminSelleoCms
  class FormMailer < ActionMailer::Base
    def form_submission(form, form_uuid)
      @form = form
      @form_uuid = form_uuid
      mail(
          to: @form.delivery_emails(@form_uuid),
          subject: I18n.t("active_admin.cms.forms.new_form_email.subject")
      )
    end
  end
end
