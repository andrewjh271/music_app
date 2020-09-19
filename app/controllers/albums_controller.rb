class AlbumsController < ApplicationController
  before_action :require_user

  def index
    if params[:id]
      @albums = Album.where(band_id: params[:band_id])
    else
      @albums = Album.all
    end
    render :index
  end

  def new
    @album = Album.new
    @album.band_id = params[:band_id]
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find_by(id: params[:id])
    render :edit
  end

  def update
    @album = Album.find_by(id: params[:id])
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def show
    @album = Album.find_by(id: params[:id])
    render :show
  end

  def destroy
    @album = Album.find_by(id: params[:id])
    @album.destroy
    redirect_to root_url
  end

  private

  def album_params
    params.require(:album).permit(:title, :year, :live, :band_id)
  end
end