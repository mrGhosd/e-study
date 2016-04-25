class Api::V0::NotificationsController < Api::ApiController
  def destroy
    notify = Notification.where(id: params[:notifications])
    if notify.destroy_all
      render json: { success: true }
    else
      render json: { success: false }
    end
  end
end
