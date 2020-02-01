class Task < ApplicationRecord
  enum priority: [:high, :normal, :low]
  enum status: [:pending, :processing, :done]

  # scope
  scope :sort_by_created_at, -> { order('created_at DESC') }
end
