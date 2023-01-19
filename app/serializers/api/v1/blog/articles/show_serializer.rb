# frozen_string_literal: true

module Api
  module V1
    module Blog
      module Articles
        class ShowSerializer < Blueprinter::Base
          identifier :id

          fields :bg_image_url, :label, :description, :content, :created_at, :published, :worth_reading, :box_size
        end
      end
    end
  end
end
