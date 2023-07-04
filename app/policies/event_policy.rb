class EventPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    user_is_owner?(record)
  end

  def destroy?
    user_is_owner?(record)
  end
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
