# frozen_string_literal: true

require 'test_helper'

class BulletinPolicyTest < ActiveSupport::TestCase
  setup do
    @bulletin_draft = bulletins(:draft)
    @bulletin_published = bulletins(:published)
    @bulletin_archived = bulletins(:archived)
    @bulletin_rejected = bulletins(:rejected)
    @bulletin_under_moderation = bulletins(:under_moderation)

    @bulletin_draft_other = bulletins(:draft_other)
    @bulletin_published_other = bulletins(:published_other)

    @user = users(:user)
    @other_user = users(:other_user)
    @admin = users(:admin)
  end

  test 'author can view all own bulletin' do
    policy = BulletinPolicy.new(@user, @bulletin_draft)
    assert policy.show?

    policy = BulletinPolicy.new(@user, @bulletin_under_moderation)
    assert policy.show?

    policy = BulletinPolicy.new(@user, @bulletin_published)
    assert policy.show?

    policy = BulletinPolicy.new(@user, @bulletin_rejected)
    assert policy.show?

    policy = BulletinPolicy.new(@user, @bulletin_archived)
    assert policy.show?
  end

  test 'non-author can not view other non-published bulletins' do
    policy = BulletinPolicy.new(@user_other, @bulletin_draft)
    assert_not policy.show?

    policy = BulletinPolicy.new(@user_other, @bulletin_under_moderation)
    assert_not policy.show?

    policy = BulletinPolicy.new(@user_other, @bulletin_rejected)
    assert_not policy.show?

    policy = BulletinPolicy.new(@user_other, @bulletin_archived)
    assert_not policy.show?
  end

  test 'user can view other published bulletin' do
    policy = BulletinPolicy.new(@user, @bulletin_published_other)
    assert policy.show?
  end

  test 'author can edit bulletin' do
    policy = BulletinPolicy.new(@user, @bulletin_published)
    assert policy.edit?
  end

  test 'non-author can not edit bulletin' do
    policy = BulletinPolicy.new(@other_user, @bulletin_published)
    assert_not policy.edit?
  end

  test 'author can send to moderation own draft bulletin' do
    policy = BulletinPolicy.new(@user, @bulletin_draft)
    assert policy.to_moderate?
  end

  test 'non-author can not send to moderation other draft bulletin' do
    policy = BulletinPolicy.new(@user, @bulletin_draft_other)
    assert_not policy.to_moderate?
  end

  test 'author can archive own bulletin' do
    policy = BulletinPolicy.new(@user, @bulletin_published)
    assert policy.archive?
  end

  test 'non-author can not archive other bulletin' do
    policy = BulletinPolicy.new(@other_user, @bulletin_published)
    assert_not policy.archive?
  end

  test 'admin can view any bulletin' do
    policy = BulletinPolicy.new(@admin, @bulletin_draft)
    assert policy.show?

    policy = BulletinPolicy.new(@admin, @bulletin_under_moderation)
    assert policy.show?

    policy = BulletinPolicy.new(@admin, @bulletin_published)
    assert policy.show?

    policy = BulletinPolicy.new(@admin, @bulletin_rejected)
    assert policy.show?

    policy = BulletinPolicy.new(@admin, @bulletin_archived)
    assert policy.show?
  end

  test 'admin can not edit or update other bulletin' do
    policy = BulletinPolicy.new(@admin, @bulletin_draft)
    assert_not policy.edit?
    assert_not policy.update?
  end
end
