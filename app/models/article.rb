class Article < ApplicationRecord
  default_scope { order(created_at: :desc) }

  scope :search_articles, ->(search) { where('title ILIKE :search OR content ILIKE :search', search: "%#{search}%") }
end
