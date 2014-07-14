class ProductPhotosController < ApplicationController
before_filter :find_product

def index
  @photos = @product.photos
end

def show
  @photo = @product.photos.find( params[:id] )
end

def new
  @photo = @product.photos.build
end

def create
  @photo = @product.photos.build( params[:photo] )
  if @photo.save
    redirect_to product_photos_url( @product )
  else
    render :action => :new
  end
end

def edit
  @photo = @product.photos.find( params[:id] )
end

def update
  @photo = @product.photos.find( params[:id] )

  if @photo.update_attributes( params[:photo] )
    redirect_to product_photos_url( @product )
  else
    render :action => :new
  end

end

def destroy
  @photo = @product.photos.find( params[:id] )
  @photo.destroy

  redirect_to product_photos_url( @product )
end

protected

def find_product
  @product = product.find( params[:product_id] )
end

    
end
