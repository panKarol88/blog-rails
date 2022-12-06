# frozen_string_literal: true

module DeviseApiOverrideHelpers
  # def password_complexity
  #   return if password.blank? || password =~ /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])/
  #
  #   errors.add :password, 'complexity',
  #              message: 'Complexity requirement not met. Please use: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
  # end

  def password_complexity
    return if password.blank? || password =~ /(?=.*?[0-9])(?=.*?[a-z])/

    errors.add :password, 'complexity', message: 'Complexity requirement not met. Please use: 1 number, 1 lowercase'
  end
end
