Rails.application.routes.draw do
  namespace :admin do
		resources :users
  end
	root to: 'tasks#index'
	resources :tasks
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
