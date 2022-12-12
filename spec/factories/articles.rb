# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    label { 'label' }
    description { 'description' }
    content { 'content' }
    bg_image_url { 'bg_image_url' }

    trait :published do
      published { true }
    end

    trait :worth_reading do
      worth_reading { true }
    end
  end
end
