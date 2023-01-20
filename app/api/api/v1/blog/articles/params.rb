# frozen_string_literal: true

module Api
  module V1
    module Blog
      module Articles
        module Params
          extend Grape::API::Helpers

          params :article do
            optional :bg_image_url, type: String
            optional :label, type: String
            optional :description, type: String
            optional :content, type: String
            optional :published, type: Boolean
            optional :worth_reading, type: Boolean
            optional :box_size, type: String
          end
        end
      end
    end
  end
end
