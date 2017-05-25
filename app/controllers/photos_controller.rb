class PhotosController < ApplicationController
  # ------ User CRUD ------
  def index
    verify_user {
      @photos = Photo.where(team: @curr_user.team)
    }
  end

  def show
    verify_user {
      @photo = Photo.find(params[:id])
      if @photo.team != @curr_user.team
        redirect_to photos_path
      end
    }
  end

  def new
    verify_user {
      @photo = Photo.new
    }
  end
  
  def create
    verify_user {
      @photo = Photo.new(photo_params)
      if @photo.save
        redirect_to photo_path(@photo)
      else
        render 'user_new'
      end
    }
  end

  def destroy
    verify_user {
      @photo = Photo.find(params[:id])
      @photo.destroy if @photo.team == @curr_user.team
      redirect_to photos_path
    }
  end
  
  # ------ Admin CRUD ------
  def admin_index
    verify_admin {
      @photos = Photo.all
    }
  end

  def admin_new
    verify_admin {
      @photo = Photo.new
    }
  end
  
  def admin_create
    verify_admin {
      @photo = Photo.new(photo_params)
      if @photo.save
        redirect_to admin_photo_path(@photo)
      else
        render 'new'
      end
    }
  end

  def admin_show
    verify_admin {
      @photo = Photo.find(params[:id])
    }
  end

  def admin_destroy
    verify_admin {
      @photo = Photo.find(params[:id])
      @photo.destroy
      redirect_to admin_photos_path
    }
  end

  private
    def photo_params
      params.require(:photo).permit(:image, :caption_text, :user_id, :team_id, :admin_uploaded)
    end
end
