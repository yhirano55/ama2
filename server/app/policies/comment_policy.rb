class CommentPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    login_user?
  end

  def show?
    true
  end

  def update?
    login_user? && (admin_user? || record_owner?)
  end

  def destroy?
    login_user? && (admin_user? || record_owner?)
  end
end
