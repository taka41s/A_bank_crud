class User < ApplicationRecord
    has_secure_password
    validates :email, uniqueness: true
    validates :email, presence: true
    has_many :bank_accounts
    has_many :amounts
    has_many :historic
    def password
        @password
    end
    
    def password=(raw)
        @password = raw
        self.password_digest = BCrypt::Password.create(password)
    end
    
    def is_password?(password)
        BCrypt::Password.new(self.password_digest) == password
    end
end
