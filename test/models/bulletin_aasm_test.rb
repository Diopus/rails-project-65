# frozen_string_literal: true

require 'test_helper'

class BulletinAasmTest < ActiveSupport::TestCase
  setup do
    @bulletin_draft = bulletins(:draft)
    @bulletin_published = bulletins(:published)
    @bulletin_archived = bulletins(:archived)
    @bulletin_rejected = bulletins(:rejected)
    @bulletin_under_moderation = bulletins(:under_moderation)
  end

  test 'should transit draft to moderation' do
    assert @bulletin_draft.may_to_moderate?
    @bulletin_draft.to_moderate!
    assert_equal 'under_moderation', @bulletin_draft.state
  end

  test 'should transit under_moderation to published' do
    assert @bulletin_under_moderation.may_publish?
    @bulletin_under_moderation.publish!
    assert_equal 'published', @bulletin_under_moderation.state
  end

  test 'should transit under_moderation to rejected' do
    assert @bulletin_under_moderation.may_reject?
    @bulletin_under_moderation.reject!
    assert_equal 'rejected', @bulletin_under_moderation.state
  end

  test 'should archive from draft' do
    assert @bulletin_draft.may_archive?
    @bulletin_draft.archive!
    assert_equal 'archived', @bulletin_draft.state
  end

  test 'should archive from under_moderation' do
    assert @bulletin_under_moderation.may_archive?
    @bulletin_under_moderation.archive!
    assert_equal 'archived', @bulletin_under_moderation.state
  end

  test 'should archive from published' do
    assert @bulletin_published.may_archive?
    @bulletin_published.archive!
    assert_equal 'archived', @bulletin_published.state
  end

  test 'should archive from rejected' do
    assert @bulletin_rejected.may_archive?
    @bulletin_rejected.archive!
    assert_equal 'archived', @bulletin_rejected.state
  end
end
