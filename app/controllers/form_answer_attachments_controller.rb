class FormAnswerAttachmentsController < ApplicationController

  def destroy
    @attachment = ActiveadminSelleoCms::FormAnswerAttachment.find(params[:id])
    @attachment.destroy
  end

end