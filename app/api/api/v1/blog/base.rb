# frozen_string_literal: true

module Api
  module V1
    module Blog
      class Base < Api::V1::Base
        resource :blog do
          route_setting :auth, disabled: true

          mount Api::V1::Blog::Articles::Base
        end
      end
    end
  end
end
