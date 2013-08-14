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

  def edit
    @form_answer = ActiveadminSelleoCms::FormAnswer.find(params[:id])
  end

  def update
    @form_answer = ActiveadminSelleoCms::FormAnswer.find(params[:id])
    @form_answer.update_attributes(params[:form_answer])
  end

  def find_or_create
    @form_answer = ActiveadminSelleoCms::FormAnswer.find_or_create_by_form_uuid_and_dom_id_and_form_question_id(params[:form_uuid], params[:dom_id], params[:form_question_id])
    render action: :edit
  end

  def attachments
    @form_answer = ActiveadminSelleoCms::FormAnswer.where(form_uuid: params[:form_uuid], form_question_id: params[:form_question_id]).first
    render partial: 'attachments'
  end

end