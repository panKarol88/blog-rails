# frozen_string_literal: true

module Api
  module V1
    module Blog
      class Base < Api::V1::Base
        resource :blog do
          mount Api::V1::Blog::Articles::Base
        end
      end
    end
  end
end
