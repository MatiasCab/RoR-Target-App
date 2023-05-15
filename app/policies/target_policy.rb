class TargetPolicy < ApplicationPolicy
  MAX_TARGETS_AMOUNT = 3

  def create?
    unless user.targets.count < MAX_TARGETS_AMOUNT
      raise Pundit::NotAuthorizedError, I18n.t('api.errors.maximum_targets_reached')
    end
    true
  end
end
