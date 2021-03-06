class User < ApplicationRecord
  validates :first_name, presence: { message: "You must enter the parent's first name" }
  validates :last_name, presence: { message: "You must enter the parent's last name" }
  validates :last_name, uniqueness: {scope: :first_name, message: "A parent with that name is already registered" }

  has_many :children
  accepts_nested_attributes_for :children, reject_if: :all_blank, allow_destroy: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:user, :guide, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  def name
    self.first_name + " " +self.last_name
  end


end
