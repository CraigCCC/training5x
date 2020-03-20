# frozen_string_literal: true

class Task < ApplicationRecord
  # validation
  validates :title, :status, :priority, :start_at, :end_at, presence: true
  validates :title, length: { maximum: 50 }
  validate :end_at_after_start_at?

  enum priority: [:high, :normal, :low]
  enum status: [:pending, :processing, :done]

  # scope
  scope :sort_by_created_at, -> { order('created_at DESC') }
  scope :sort_by_column, ->(order_by, direction) { order("#{order_by} #{direction}") }
  scope :search_title, ->(title) { title.present? ? where('title ILIKE ?', "%#{title}%") : all }
  scope :search_status, ->(status) { status.present? ? where('status = ?', status) : all }

  private

  def end_at_after_start_at?
    return if (end_at && start_at).nil?

    errors.add :end_at, I18n.t('errors.messages.invaild_date') if end_at < start_at
  end
end
