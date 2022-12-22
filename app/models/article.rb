# frozen_string_literal: true

class Article < ApplicationRecord
  scope :published, ->(published = true) { where(published:) }
  scope :worth_reading, ->(worth_reading = true) { where(worth_reading:) }

  enum box_size: { small: 0, medium: 1, large: 2 }

  # scope :for_types, ->(*article_types) { article_types == ['all'] ? all : where(article_type: article_types) }

  def self.search(search_term)
    where('label ilike ? OR description ilike ?', "%#{search_term}%", "%#{search_term}%")
  end
end
