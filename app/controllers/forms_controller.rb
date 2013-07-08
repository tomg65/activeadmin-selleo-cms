class FormsController < ApplicationController
  respond_to :html, :pdf

  before_filter do
    @form = ActiveadminSelleoCms::Form.find(params[:id])
  end

  def download
    respond_to do |format|
      format.pdf do
        render :pdf => @form.title.parameterize
      end
    end
  end

  def deliver
    respond_to do |format|
      format.html do
        pdf = WickedPdf.new.pdf_from_string(
            render_to_string('download.pdf.erb')
        )
        pdf_path = File.join(ActiveadminSelleoCms::Form::PDF_PATH, "#{@form.title.parameterize}-#{Time.now.to_s.parameterize}.pdf")
        File.open(pdf_path, 'wb') do |file|
          file << pdf
        end
        ActiveadminSelleoCms::FormMailer.form_submission(pdf_path).deliver
        flash[:notice] = "Your form has been sent. Thank you."
      end
    end
  end

end