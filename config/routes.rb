Rails.application.routes.draw do
  get 'cache/getByTypeId'

  get 'cache/getByCodeId'

  post 'cache/refresh'

  get 'data/list'

  get 'migrate/import'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
