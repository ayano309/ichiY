Rails.application.routes.draw do
  root 'home#top'
  get 'terms', to: 'home#terms'
  get 'privacy', to: 'home#privacy'
  get 'about', to: 'home#about'
end
