# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  email            :string           not null
#  password_digest  :string           not null
#  session_token    :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  activated        :boolean          default(FALSE), not null
#  activation_token :string           not null
#
class User < ApplicationRecord
  attr_reader :password

  validates :email, :session_token, presence: true
  validates :email, uniqueness: true
  # validates :password_digest, presence: { message: 'Password can\'t be blank' }
  validates :password, length: { minimum: 6, allow_nil: true }
  validate :require_password_digest

  after_initialize :ensure_tokens

  has_many :notes

  def self.find_by_credentials(email, password)
    user = self.find_by(email: email)
    user.try(:is_password?, password) ? user : nil
  end

  def password=(password)
    @password = password

    return if password.empty?
    # don't want to set password digest for blank password (mainly for error messages and tests,
    # since password = '' would fail password length requirement anyway)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def reset_session_token!
    update(session_token: generate_token)
    session_token
  end

  private

  def ensure_tokens
    self.session_token ||= generate_token
    self.activation_token ||= generate_token
  end

  def generate_token
    SecureRandom.urlsafe_base64
  end

  def require_password_digest
    # custom method here because I don't want errors message to be 'Password_digest Password can't be blank
    errors[:base] << 'Password can\'t be blank' unless password_digest
  end
end
