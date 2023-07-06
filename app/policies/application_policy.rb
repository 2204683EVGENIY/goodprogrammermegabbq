# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record, :cookies, :params

  def initialize(user, record)
    @user = user.user
    @record = record
    @cookies = user.cookies
    @params = user.params
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end

  private

  def user_is_owner?(record)
    user.present? && (record.user == user || (record.try(:event).present? && record.event.user == user))
  end
end
