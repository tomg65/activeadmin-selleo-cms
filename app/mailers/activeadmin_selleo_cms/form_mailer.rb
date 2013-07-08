module ActiveadminSelleoCms
  class FormMailer < ActionMailer::Base
    default from: "web-form@jips.org"

    def form_submission(form_filename)
      attachments[form_filename] = File.read(form_filename)
      mail(to: 'aossowski@gmail.com', subject: "New form submission")
    end
  end
end
