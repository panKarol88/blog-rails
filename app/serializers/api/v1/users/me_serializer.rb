# frozen_string_literal: true

module Api
  module V1
    module Users
      class MeSerializer < Blueprinter::Base
        identifier :id

        fields :email, :nickname, :type
      end
    end
  end
end
