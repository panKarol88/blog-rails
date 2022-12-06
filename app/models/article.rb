# frozen_string_literal: true

class Article < ApplicationRecord
  enum article_type: { public: 0, personal: 1 }, _prefix: true

  validates :article_type, presence: true, inclusion: { in: article_types }

  scope :for_types, ->(*article_types) { article_types == ['all'] ? all : where(article_type: article_types) }

  def self.search(search_term)
    where('label ilike ? OR description ilike ?', "%#{search_term}%", "%#{search_term}%")
  end
end
