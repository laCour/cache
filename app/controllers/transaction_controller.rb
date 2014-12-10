class TransactionController < ApplicationController
  before_action :require_listing_via_ajax
  before_action :require_transaction_via_ajax, only: :show

  def new
    new_address = Transaction.new.new_address()
    Transaction.create(new_address.merge(listing_id: @listing.id, amount: @listing.amount))

    new_address[:amount] = @listing.amount
    render json: new_address
  end

  def show
    if @transaction.captured?
      render json: { download: @listing.document.expiring_url(600) }
    end
  end

  private

  def require_ajax
    render json: '{}' and return unless request.xhr?
  end

  def require_listing_via_ajax
    require_ajax()
    @listing = Listing.find_by token: params[:id]
    render json: '{}' and return if @listing.nil?
  end

  def require_transaction_via_ajax
    require_ajax()
    @transaction = Transaction.find_by label: params[:label]
    render json: '{}' and return if @transaction.nil? or @transaction.captured
  end
end
