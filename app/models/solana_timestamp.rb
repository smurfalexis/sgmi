class SolanaTimestamp < ApplicationRecord
  after_commit :async_update # Run on create & update

  private

  def async_update
    DailySolanaJob.perform_later(self)
  end
end
