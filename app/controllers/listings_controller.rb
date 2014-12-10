class ListingsController < ApplicationController
  before_action :requires_key, except: [:new, :create, :show]
  before_action :uses_key, only: [:show]

  def new
    @listing = Listing.create
    session[:key] = @listing.key
    redirect_to edit_listing_path(@listing.token)
  end

  def show
    render 'incomplete' if @listing.incomplete?
  end

  def update
    @listing.update(listing_params)

    render json: { url: @listing.cover.url } and return if request.xhr?

    if @listing.complete? and @listing.errors.empty?
      redirect_to listing_path(@listing.token) and return
    end

    render 'edit'
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :description, :amount, :address, :cover, :document)
  end

  def key
    @listing = Listing.find_by token: params[:id]

    if params[:key].present?
      key = session[:key] = params[:key]
    else
      key = session[:key]
    end

    if key == @listing.key then key else nil end
  end

  def uses_key
    @key = key()
  end

  def requires_key
    if key().nil? then redirect_to listing_path(params[:id]) end
  end
end
