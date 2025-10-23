class WalletDepositsController < ApplicationController
  before_action :authenticate_user!

  def new
    @transaction = current_user.wallet.transactions.new
  end

  def create
    amount = params[:transaction][:amount].to_d
    if amount <= 0
      redirect_to new_wallet_deposit_path, alert: "Invalid amount"
      return
    end

    transaction = current_user.wallet.transactions.create!(
      amount: amount,
      transaction_type: 'deposit',
      status: 'pending'
    )

    options = {
      body: {
        userSecretKey: ENV.fetch('TOYYIBPAY_USER_SECRET_KEY'),
        categoryCode: ENV.fetch('TOYYIBPAY_CATEGORY_CODE'),
        billName: "Wallet Deposit",
        billDescription: "Deposit for #{current_user.email}",
        billPriceSetting: 1,
        billPayorInfo: 1,
        billAmount: (amount * 100).to_i,
        billReturnUrl: wallet_url,
        billCallbackUrl: toyyibpay_webhook_url,
        billExternalReferenceNo: transaction.id,
        billTo: current_user.email,
        billEmail: current_user.email,
        billPhone: '0000000000',
        billSplitPayment: 0,
        billSplitPaymentArgs: '',
        billPaymentChannel: 0,
      }.to_json,
      headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
    }

    response = HTTParty.post("#{Rails.configuration.x.toyyibpay_base_url}/index.php/api/createBill", options)
    parsed_response = JSON.parse(response.body)

    if parsed_response.is_a?(Array) && parsed_response.first['BillCode']
      bill_code = parsed_response.first['BillCode']
      transaction.update!(payment_gateway_transaction_id: bill_code)
      redirect_to "#{Rails.configuration.x.toyyibpay_base_url}/#{bill_code}", allow_other_host: true
    else
      transaction.update!(status: 'failed')
      redirect_to new_wallet_deposit_path, alert: "Failed to create payment bill. Please try again."
    end
  end
end
