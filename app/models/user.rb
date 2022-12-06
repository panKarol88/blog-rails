# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :validatable, :jwt_authenticatable # , jwt_revocation_strategy: JwtDenylist

  include Discard::Model
  include DeviseApiOverrideHelpers

  validate :password_complexity
  validates :type, presence: true

  def self.search(search_term)
    where('nickname ilike ? OR email ilike ?', "%#{search_term}%", "%#{search_term}%")
  end

  def active
    kept?
  end

  def self.types
    User.subclasses.map(&:name)
  end

  # :reek:BooleanParameter
  def respond_to_missing?(method, include_private = false)
    missing_type?(method) || super
  end

  def method_missing(method, *args, &)
    super unless missing_type?(method)

    type == method.to_s.split('?').first.capitalize
  end

  private

  # :reek:UtilityFunction
  def missing_type?(method)
    User.types.map { |type| "#{type.downcase}?" }.include?(method.to_s)
  end
end
