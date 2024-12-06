# frozen_string_literal: true

module FieldLengthHelper
  module_function

  extend ActiveSupport::Concern

  # extracts values set for the length validator of the field
  def get_field_length_validator_value(model, field, length_validator_type)
    validators = model.validators_on(field)
    length_validator = validators.find { |v| v.is_a?(ActiveRecord::Validations::LengthValidator) }
    length_validator&.options&.[](length_validator_type)
  end
end
