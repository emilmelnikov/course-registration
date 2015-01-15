# == Schema Information
#
# Table name: courses
#
#  id            :integer          not null, primary key
#  title         :string
#  credits       :integer
#  max_attendees :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Course < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :title, :credits, :max_attendees, presence: true
  validates :credits, :max_attendees, numericality: {only_integer: true, greater_than: 0}
end
