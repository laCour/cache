class ListingsController < ApplicationController
  before_action :requires_key, except: [:new, :create, :show, :cover_upload]
  before_action :uses_key, only: [:show]

  def new
    @listing = Listing.new
    @cover_photo = @listing.build_cover_photo
    session[:key] = @listing.key
  end

  def create
    @listing = Listing.new(listing_params)

    if @listing.save
      flash[:success] = "You've listed \"#{@listing.title}\" for sale"
      redirect_to listing_path(@listing.token, :key => @listing.key) and return
    else
      @cover_photo = CoverPhoto.find(params[:listing][:cover_photo_token])
      render :new
    end
  end

  def show
    @cover_photo = @listing.cover_photo
  end

  def edit
    @cover_photo = @listing.cover_photo || @listing.build_cover_photo
  end

  def update
    @listing.update(listing_params)
    
    if @listing.save
      flash[:success] = "You've updated the listing \"#{@listing.title}\""
      redirect_to listing_path(@listing.token) and return
    else
      @cover_photo = @listing.cover_photo
      render 'edit'
    end
  end

  def destroy
    if @listing.destroy
      flash[:success] = "You've deleted the listing \"#{@listing.title}\""
      redirect_to root_path and return
    else
      flash[:error] = "You cannot delete this listing."
      redirect_to listing_path(@listing.token) and return
    end
  end

  def cover_upload
    @cover_photo = CoverPhoto.create(cover_photo_params)
    render json: { url: @cover_photo.image.url, cover_photo_id: @cover_photo.id } and return if request.xhr?
  end

  private

  def cover_photo_params
     params.require(:cover_photo).permit(:image)
  end

  def listing_params
    params.require(:listing).permit(:title, :description, :amount, :address, :document, :cover_photo_token)
  end

  def key
    @listing = Listing.find_by token: params[:id]

    if params[:key].present?
      key = session[:key] = params[:key]
    else
      key = session[:key]
    end

    key == @listing.key ? key : nil
  end

  def uses_key
    @key = key()
  end

  def requires_key
    redirect_to listing_path(params[:id]) if key().nil?
  end
end
