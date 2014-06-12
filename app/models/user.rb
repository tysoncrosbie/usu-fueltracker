class User < ActiveRecord::Base
  extend FriendlyId

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  friendly_id :name, use: [:slugged, :history]
  rolify


## Scopes
  ROLES.each do |r|
    scope r, -> { includes(:roles).references(:roles).where('roles.name = ?', r) }
  end


## Validations
  validates :email, presence: true
  validates :email, uniqueness: { allow_blank: true }, if: :email_changed?
  validates :email, format: { with: Devise.email_regexp, allow_blank: true }, if: :email_changed?
  validates :password, presence: true, confirmation: true, length: { within: Devise.password_length, allow_blank: true }, if: :password_required?

private

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

end
