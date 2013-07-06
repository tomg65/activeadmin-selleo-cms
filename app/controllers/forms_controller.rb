class FormsController < ApplicationController
  respond_to :html, :pdf

  before_filter do
    @form = ActiveadminSelleoCms::Form.find(params[:id])
  end

  def download
    respond_to do |format|
      format.pdf do
        render :pdf => @form.title
      end
    end
  end

  def deliver

  end

end