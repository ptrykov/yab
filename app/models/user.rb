class User < ActiveRecord::Base

  has_secure_password
  validates :password, length: {minimum: 8}
  validates :firstname, :lastname, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

end
