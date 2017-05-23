Rails.application.routes.draw do
  get 'dictCodes' => 'cache#get_by_type_id'

  get 'dictCodes/:id' => 'cache#get_by_code_id'

  post 'dictCodes' => 'cache#refresh'

  get 'data/list'

  get 'migrate/import'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
