class CocktailPolicy < ApplicationPolicy
  def show?
    true
  end

  def new?
    true
  end

  def create?
    return true
  end

  def edit?
    record.user == user
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  class Scope < Scope
    def resolve
      scope.all
      # scope.where({user: current_user})
    end
  end
end
