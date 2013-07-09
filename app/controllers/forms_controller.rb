class FormsController < ApplicationController
  respond_to :html, :pdf

  before_filter do
    @form = ActiveadminSelleoCms::Form.find(params[:id])
  end

  def download
    ActiveadminSelleoCms::FormAnswer.where(form_uuid: params[:form_uuid])

    respond_to do |format|
      format.pdf do
        render :pdf => @form.title.parameterize, :show_as_html => false
      end
      format.html do
        render :pdf => @form.title.parameterize, :show_as_html => true
      end
    end
  end

  def deliver
    respond_to do |format|
      format.html do
        ActiveadminSelleoCms::FormMailer.form_submission(@form, params[:form_uuid]).deliver
        flash[:notice] = "Your form has been sent. Thank you."
      end
    end
  end

  def answer; end

end