class EnrollmentsController < ApplicationController
  def edit
  end

  def update
    User.find(current_user.id).update(user_params)
    redirect_to edit_enrollments_url
  end

  private

  def user_params
    params.require(:user).permit(course_ids: [])
  end
end
