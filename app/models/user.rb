class User < ApplicationRecord

    has_many :microposts, dependent: :destroy
    has_many :active_relationships, class_name:  "Relationship",
    foreign_key: "follower_id",
    dependent:   :destroy
    has_many :passive_relationships, class_name:  "Relationship",
    foreign_key: "followed_id",
    dependent:   :destroy

    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower

    before_save { self.email = email.downcase }

    validates :username, presence: true, 
    uniqueness: { case_sensitive: false }, 
    length: { minimum: 3, maximum: 25 }
        VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email, presence: true, 
    uniqueness: { case_sensitive: false }, 
    length: { maximum: 105 },
    format: { with: VALID_EMAIL_REGEX }

    has_secure_password


    def feed
        following_ids = "SELECT followed_id FROM relationships
        WHERE  follower_id = :user_id"
Micropost.where("user_id IN (#{following_ids})
        OR user_id = :user_id", user_id: id)
      end
       # Начать читать сообщения пользователя.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Перестать читать сообщения пользователя.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Возвращает true, если текущий пользователь читает сообщения другого пользователя.
  def following?(other_user)
    following.include?(other_user)
  end
end