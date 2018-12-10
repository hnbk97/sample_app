Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "help" => "static_pages#help"
    get "about" => "static_pages#about"
  end
end
