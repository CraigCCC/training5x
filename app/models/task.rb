class Task < ApplicationRecord
  enum priority: [:high, :normal, :low]
  enum status: [:pending, :processing, :done]
end
