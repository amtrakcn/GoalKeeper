class User < ActiveRecord::Base
  attr_accessible :username, :password
  attr_reader :password

  validates :username, :password_digest, :presence => true
  validates :username, :uniqueness => true
  validates :password, :length => { minimum: 6 }, :on => :create

  has_many :goals

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    pw = BCrypt::Password.new(self.password_digest)
    pw.is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.where(:username => username).first

    if !!user
      return user if user.is_password?(password)
    end
    nil
  end

  def reset_token!
    self.session_token = SecureRandom::urlsafe_base64(16)
    self.save
    self.session_token
  end
end
