class User < ActiveRecord::Base

  has_secure_password
  validates :password, length: {minimum: 8}
  validates :firstname, :lastname, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

  has_many :posts, dependent: :destroy
  
  has_and_belongs_to_many :roles


  private

  def method_missing(method, *args)
    if match = match_role(method)
      roles_to_array(match.captures.first).each do |check|
        return true if roles.map{|r| r.name.downcase}.include?(check)
      end
      return false
    else
      super
    end
  end

  def match_role(method)
    /^is_([a-zA-Z]\w*)\?$/.match(method.to_s)
  end

  def roles_to_array(string)
    string.split(/_or_/)
  end
end
