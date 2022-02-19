Rails.application.routes.draw do
  root "application#home"
  post '/upload' => 'application#upload_csv'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
