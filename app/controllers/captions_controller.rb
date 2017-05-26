class CaptionsController < ApplicationController
  def edit
    verify_user {
      @photo = Photo.find(params[:photo_id])
      if @curr_user != @photo.user
        redirect_to back
      else
        @caption = @photo.caption
      end
    }
  end

  def update
    verify_user {
      @photo = Photo.find(params[:photo_id])
      if @curr_user != @photo.user
        redirect_to back
      else
        @caption = @photo.caption
        if @caption.update(caption_params)
          redirect_to photo_path(@photo)
        else
          render 'edit'
        end
      end
    }
  end

  def admin_edit
    verify_admin {
      @caption = Caption.find(params[:id])
    }
  end

  def admin_update
    verify_admin {
      @caption = Caption.find(params[:id])
      if @caption.update(caption_params)
        redirect_to admin_photo_path(@photo)
      else
        render 'admin_edit'
      end
    }
  end

  private
    def caption_params
      params.require(:caption).permit(:text)
    end
end
