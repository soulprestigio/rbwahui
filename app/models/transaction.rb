class Transaction < ApplicationRecord
  belongs_to :wallet

  validates :transaction_type, inclusion: { in: %w(deposit withdrawal bet), message: "%<value>s is not a valid transaction type" }
  validates :status, inclusion: { in: %w(pending completed failed), message: "%<value>s is not a valid status" }
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
