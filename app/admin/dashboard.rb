def generate_report
end

ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  page_action :download_report do

    sheet = CSV.generate do |csv|
      all_courses = Course.all

      user_info_header = ['First name', 'Last name', 'Email']
      course_titles = all_courses.map { |c| c.title }
      csv << user_info_header + course_titles

      User.find_each do |user|
        user_info = [user.first_name, user.last_name, user.email]
        user_courses = all_courses.map { |c| user.courses.include?(c) ? '1' : '' }
        csv << user_info + user_courses
      end
    end

    now = Time.zone.now.strftime('%Y-%m-%d-%H-%M')
    send_data sheet, filename: "course-registration-#{now}.csv", type: 'text/csv'
  end

  action_item :download_report do
    link_to 'Download report', admin_dashboard_download_report_path
  end

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
