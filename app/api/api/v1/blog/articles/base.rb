# frozen_string_literal: true

module Api
  module V1
    module Blog
      module Articles
        class Base < Api::V1::Blog::Base
          resource :articles do
            mount Api::V1::Blog::Articles::Index
            mount Api::V1::Blog::Articles::Show
            mount Api::V1::Blog::Articles::Update
            mount Api::V1::Blog::Articles::Delete
            mount Api::V1::Blog::Articles::Create
          end
        end
      end
    end
  end
end
