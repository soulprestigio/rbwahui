class ToyyibpayWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    transaction = Transaction.find(params[:order_id])

    if params[:status] == '1' # Success
      ActiveRecord::Base.transaction do
        transaction.update!(status: 'completed')
        transaction.wallet.increment!(:balance, transaction.amount)
      end
    elsif params[:status] == '3' # Failed
      transaction.update!(status: 'failed')
    end

    head :ok
  end
end
