ActiveAdmin.register ActiveadminSelleoCms::FormQuestion, as: 'FormQuestion' do
  belongs_to :form
  actions :all, except: [:show]
  menu false

  collection_action :sort, :method => :get do
    params[:ids].split(",").each_with_index do |id, index|
      ActiveadminSelleoCms::FormQuestion.update_all(['position=?', index+1], ['id=?', id.to_i])
    end
    render :nothing => true
  end

  controller do

    def new
      set_form
      @form_question = @form.questions.new(question_type: params[:question_type])
      render :partial => 'form', :layout => false
    end

    def create
      set_form
      @form_question = @form.questions.new(params[:form_question])
    end

    def edit
      set_form
      set_question
      render :partial => 'form', :layout => false
    end

    def update
      set_form
      set_question
      @form_question.update_attributes(params[:form_question])
    end

    def destroy
      set_form
      set_question
    end

    def set_form
      @form = ActiveadminSelleoCms::Form.find(params[:form_id])
    end

    def set_question
      @form_question = @form.questions.find(params[:id])
    end

  end

end