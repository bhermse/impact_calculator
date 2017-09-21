Rails.application.routes.draw do
  root to: "calculator#home"
  get 'calculator/home'
end
