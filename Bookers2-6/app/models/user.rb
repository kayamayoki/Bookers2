class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :books, dependent: :destroy 
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed  #自分がフォローしている人
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy 
  has_many :follower_user, through: :followed, source: :follower　#自分をフォローしている人
  
  attachment :profile_image
  
  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }

  def follow(user_id)
    follower.create(followed_id: user_id)
  end
  
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  
  def following?(user)
    following_user.include?(user)
  end
  
  def self.looks(searches, words)
    if searches == "perfect_match" #完全一致
      @user = User.where("name LIKE ?", "#{words}")
    else
      @user = User.where("name LIKE ?", "%#{words}%")
    end
    
    if searches == "partial_match" #部分一致
      @user = User.where("name LIKE ?", "%#{words}%")
    end
    
    if searches == "forward_match" #前方一致
      @user = User.where("name LIKE?", "#{words}%")
    else
      @user = User.where("name LIKE ?", "%#{words}%")
    end

    if searches == "backward_match" #後方一致
      @user = User.where("name LIKE ?", "%#{words}")
    else
      @user = User.where("name LIKE ?", "%#{words}%")
    end
  end
end
