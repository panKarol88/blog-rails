Rails.application.routes.draw do
  mount Api::Root => '/'

  GrapeSwaggerRails::Engine.middleware.use Rack::Auth::Basic do |username, password|
    username == ENV.fetch('SWAGGER_USERNAME') && password == ENV.fetch('SWAGGER_PASSWORD')
  end unless Rails.env.production?

  mount GrapeSwaggerRails::Engine => '/swagger' unless Rails.env.production?
  devise_for :users, api_only?: true
end

