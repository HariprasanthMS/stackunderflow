class User < ApplicationRecord
  before_save { self.email = email.downcase }

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy

  has_many :user_topic_relations, dependent: :destroy
  has_many :topics, through: :user_topic_relations  

  attr_accessor :remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, 
             length: { maximum: 255},
             format: { with: VALID_EMAIL_REGEX }, 
             uniqueness: true
  validates :password, presence: true, length: {minimum: 6 }, allow_nil: true
  
  has_secure_password

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(self.remember_token))
    remember_digest
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Returns a session token to prevent session hijacking.
  # We reuse the remember digest for convenience.
  def session_token
    remember_digest || remember
  end

  # Follows a topic.
  def follow(topic)
    topics << topic unless topics.include?(topic)
  end

  # Unfollows a topic.
  def unfollow(topic)
    topics.delete(topic)
  end

  # Returns true if the current user is following the other user.
  def following?(topic)
    topics.include?(topic)
  end

  def send_mail
    message = 'Your question has been answered. Kindly checkout the website for the answer'
    ContactMailer.send_notification(name, email, message).deliver_later
  end
end
