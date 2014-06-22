class User < ActiveRecord::Base
  has_many :favorites

  validates :name,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: /\A[a-zA-Z_]+\z/ }
  validates :pushover_token, presence: true

  before_create :set_access_token

  has_secure_password

  def as_json(options = {})
    super only: [:id, :name, :access_token, :created_at, :updated_at]
  end

  def authorized?(access_token)
    self.access_token == access_token
  end

  private

  def set_access_token
    self.access_token = SecureRandom.hex
  end
end
