# frozen_string_literal: true

module ApplicationHelper
  include FieldLengthHelper

  def active?(path, options = {})
    # raise options.inspect
    if options.key? :active_if
      'active' if options[:active_if]
    elsif current_page?(path)
      'active'
    end
  end

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

  # rubocop:disable Rails/OutputSafety
  def sidebar_menu_item(name, fa_class = nil, path = '#', *args, &)
    args_options = args.extract_options!
    options = { class: class_names('nav-link text-body ps-0', 'fw-bold': active?(path)) }.merge args_options
    tag.li class: 'nav-item mb-3' do
      link_to path, options do
        [
          if fa_class
            tag.span(nil, class: "bi #{fa_class} me-2")
          end,
          tag.span(name, class: '', &)
        ].join.html_safe
      end
    end
  end
  # rubocop:enable Rails/OutputSafety
end
