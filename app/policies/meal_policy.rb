class MealPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end

    def show?
      return true
    end

    def new?
      return true
    end

    def create?
      return true
    end

  end
end
