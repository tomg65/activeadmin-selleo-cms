class FormAnswersController < ApplicationController

  respond_to :html, :json

  def create
    params[:form_answer] ||= {}
    if answer = ActiveadminSelleoCms::FormAnswer.where(form_uuid: params[:form_answer][:form_uuid], dom_id: params[:form_answer][:dom_id]).first
      answer.update_attribute(:value, params[:form_answer][:value])
    else
      ActiveadminSelleoCms::FormAnswer.create(params[:form_answer])
    end
    render nothing: true
  end

  def index
    respond_with ActiveadminSelleoCms::FormAnswer.where(form_uuid: params[:form_uuid])
  end

end