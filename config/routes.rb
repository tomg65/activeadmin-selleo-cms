Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  resources :forms, :only => [] do
    member do
      get :download
      get :deliver
    end
  end

  resources :form_answers do
    collection do
      post :find_or_create
      get :attachments
    end
    resources :form_answer_attachments, only: :destroy
  end

  scope ":locale", :locale => /\w{2}/ do
    scope "search" do
      resources :searches, path: '', only: [:show]
    end
    # TODO refactor
    match ':slug5(/:slug4(/:slug3(/:slug2(/:slug1))))'  => 'pages#show', via: [:get, :post]
    resources :pages, path: '', only: [:show, :index]
  end

  match ':locale' => 'pages#show', via: [:get, :post]

  root to: 'pages#show'

  resources :locales, only: :show
end