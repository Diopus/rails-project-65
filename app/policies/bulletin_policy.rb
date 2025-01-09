# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  attr_reader :user, :bulletin

  def initialize(user, bulletin)
    @user = user
    @bulletin = bulletin
  end

  def show?
    author? || admin?
  end

  def edit?
    author?
  end

  def update?
    edit?
  end

  def destroy?
    admin?
  end

  def to_moderate?
    author?
  end

  private

  def admin?
    user&.admin?
  end

  def author?
    user && bulletin.user == user
  end
end
