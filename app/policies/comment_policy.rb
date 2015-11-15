class CommentPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    admin_rights || owner || post_owner
  end
  
  def destroy?
    admin_rights || owner || post_owner
  end


  private

  def post_owner
    return true if record.post.user == user
  end
  
end
