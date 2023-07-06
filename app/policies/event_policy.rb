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

  def show?
    return true if record.pincode.blank?
    return true if user.present? && record.user == user

    if params[:pincode].present? && record.pincode_valid?(params[:pincode])
      cookies.permanent["event_#{record.id}_pincode"] = params[:pincode]
    end

    return false unless record.pincode_valid?(cookies.permanent["event_#{record.id}_pincode"])

    true
  end
end
