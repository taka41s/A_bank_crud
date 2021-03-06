Rails.application.routes.draw do
  get 'register' => 'users#new'
  post 'register' => 'users#create'
  get 'close_account' => 'sessions#close_account'
  get '/:user_id/edit' => 'users#edit_account'
  post '/:user_id/edit' => 'users#set_user_edit'
  ######
  get 'login' => 'sessions#new'
  post 'login'=> 'sessions#create'
  get 'logout' => 'sessions#logout'
  ######
  get 'deposit' => 'deposits#new'
  post 'deposit' => 'deposits#create'
  get 'home' => 'historics#index'
  get 'deposits_history' => 'historics#deposits_history'
  get 'transactions_history' => 'historics#transactions_history'
  get 'withdraws_history' => 'historics#withdraws_history'
  ######
  get 'withdraw' => 'withdraw#new'
  post 'withdraw' => 'withdraw#create'
  get 'withdraw_historic' => 'withdraw#show'
  ######
  get 'transactions' => 'transactions#new'
  post 'transactions' => 'transactions#create'
  get 'overview' => 'transactions#show'
  root to: 'sessions#new'
end
