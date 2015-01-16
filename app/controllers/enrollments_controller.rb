class EnrollmentsController < ApplicationController
  def edit
  end

  def update
    if current_user.update(user_params)
      flash[:notice] = 'Your preferences was successfully updated'
    else
      flash[:alert] = current_user.errors[:base]
    end
    redirect_to edit_enrollments_url
  end

  private

  def user_params
    params.require(:user).permit(course_ids: [])
  end
end
