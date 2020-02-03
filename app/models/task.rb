class Task < ApplicationRecord
  # validation
  validates :title, :status, :priority, :start_at, :end_at, presence: true
  validates :title, length: { maximum: 50 }
  validate :end_at_after_start_at?

  enum priority: [:high, :normal, :low]
  enum status: [:pending, :processing, :done]

  # scope
  scope :sort_by_created_at, -> { order('created_at DESC') }
  private

  def end_at_after_start_at?
    return if errors.messages.present?
    return if (end_at && start_at).nil?

    errors.add :end_at, I18n.t('errors.messages.invaild_date') if end_at < start_at
  end
end
