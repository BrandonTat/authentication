class User < ActiveRecord::Base
  validates :username, :password_digest, presence: true
  validates :password, length: { minimum: 6 }, allow: nil

  after_initialize :generate_session_token

  attr_reader :password

  def generate_session_token
    self.session_token ||= SecureRandom::urlsafe_base64(32)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(32)
    self.save
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)

    user = User.find_by(username: username)
    if user && user.is_password?(password)
      return user
    end
    nil
  end
end
