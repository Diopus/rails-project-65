# frozen_string_literal: true

module ApplicationHelper
  include FieldLengthHelper

  def bootstrap_flash_class(type)
    case type
    when 'notice' then 'alert-primary'
    when 'alert' then 'alert-danger'
    when 'success' then 'alert-success'
    when 'info' then 'alert-info'
    when 'warning' then 'alert-warning'
    else 'alert-secondary'
    end
  end

  # builds hint for the length of the field's content on the form
  def build_field_length_hint(model, field)
    max_length = get_field_length_validator_value(model, field, :maximum)
    min_length = get_field_length_validator_value(model, field, :minimum)

    return nil if max_length.nil? && min_length.nil?

    hint_key = determine_hint_key(min_length, max_length)

    hint_key.nil? ? nil : I18n.t("hints.length.#{hint_key}", min_length:, max_length:, count: max_length || min_length)
  end

  def determine_hint_key(min_length, max_length)
    if min_length && max_length
      'min_max_length'
    elsif max_length
      'max_length'
    elsif min_length
      'min_length'
    end
  end
end
