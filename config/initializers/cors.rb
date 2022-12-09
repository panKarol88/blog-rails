Rails.application.config.middleware.insert_before 0, Rack::Cors do
  # allow do
  #   origins '*'
  #   resource '*', headers: :any, methods: [:get, :post, :patch, :put]
  # end

  allow do
    origins 'localhost:3000', '127.0.0.1:3000', 'https://karol-blog-react.herokuapp.com',
            /\Ahttp:\/\/192\.168\.0\.\d{1,3}(:\d+)?\z/

    resource '*', headers: :any, methods: [:get, :post, :patch, :put, :delete], expose: ['Authorization']
  end
end
