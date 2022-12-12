# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@domain.com" }
    sequence(:nickname) { |n| "user#{n}@domain.com" }
    password { 'eloelo320' }

    trait :admin do
      initialize_with { Admin.new }

      type { 'Admin' }
    end

    trait :guest do
      initialize_with { Guest.new }

      type { 'Guest' }
    end
  end
end
