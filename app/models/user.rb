class User < ActiveRecord::Base
  has_many :browsers, dependent: :destroy
  has_many :tracks, dependent: :destroy

	has_secure_password
  before_save { email.downcase! }
  before_create :create_remember_token
	validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true,
										format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, on: :create
  self.per_page = 10

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def browser_feed
    # This is preliminary. See "Following users" for the full implementation.
    Browser.where("user_id = ?", id)
  end

  def track_feed
    # This is preliminary. See "Following users" for the full implementation.
    Track.where("user_id = ?", id)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end
