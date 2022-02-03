Rails.application.routes.draw do
  get 'register' => 'users#new'
  post 'register' => 'users#create'
  ######
  get 'login' => 'sessions#new'
  post 'login'=> 'sessions#create'
  ######
  get 'deposit' => 'deposits#new'
  post 'deposit' => 'deposits#create'
  get 'historic' => 'deposits#show'
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
