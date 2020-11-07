class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def my_bookings?
    true
  end

  def create?
    true
  end

  def destroy?
    user == record.user || user.admin
  end
end
