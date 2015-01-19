# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string
#  last_name              :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :courses

  validates :first_name, :last_name, presence: true
  validate :ensure_min_credits, on: :update
  validate :disallow_enrollment_on_full_courses, on: :update

  def total_credits
    courses.map { |c| c.credits }.sum
  end

  private

  MIN_CREDITS = 18

  def ensure_min_credits
    if total_credits < MIN_CREDITS
      errors[:base] << "Required minimum is #{MIN_CREDITS} credits"
    end
  end

  def disallow_enrollment_on_full_courses
    courses.each do |course|
      if course.places_left < 0
        errors[:base] << "Course #{course.title} already full"
      end
    end
  end
end
