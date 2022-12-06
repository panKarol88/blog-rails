# frozen_string_literal: true

module Api
  class Root < Grape::API
    prefix 'api'

    mount Api::V1::Base
    add_swagger_documentation
  end
end
