ActiveAdmin.register Course do
  permit_params :title, :credits, :max_attendees
end
