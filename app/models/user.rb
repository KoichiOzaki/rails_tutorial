class User < ApplicationRecord
  # before_save { self.email = email.downcase }
  before_save { email.downcase! }

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
             format: { with: VALID_EMAIL_REGEX },
            #uniqueness: { case_sensitive: false }で大文字小文字区別なし。
            # DBもunique: trueし、before_saveで小文字化して保存するように。
             uniqueness: { case_sensitive: false }
  # passwordをハッシュ化してくれる！password_digestカラムとgem'bcrypt'が必要
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
