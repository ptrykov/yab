class PostPolicy < ApplicationPolicy

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
    admin_rights || owner
  end
  
  def destroy?
    admin_rights || owner
  end
  
end
