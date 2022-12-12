# frozen_string_literal: true

module Api
  module V1
    module Blog
      module Articles
        class IndexSerializer < Blueprinter::Base
          identifier :id

          fields :bg_image_url, :label, :description, :created_at
        end
      end
    end
  end
end
