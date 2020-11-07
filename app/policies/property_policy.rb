class PropertyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    # user == record.user || user.admin
  end

  def destroy?
    # user == record.user || user.admin
  end

  def bookings_on_my_properties?
    true
  end
end
