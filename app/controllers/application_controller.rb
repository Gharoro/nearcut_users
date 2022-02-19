require 'csv'

class ApplicationController < ActionController::Base
  def home; end

  def upload_csv
    @result_array = []

    CSV.foreach(upload_params[:csv_file], headers: true, col_sep: ',') do |row|
      # Attempt to create users
      result = User.create(row.to_hash)
      if result.id
        # User created successfuly
        @result_array << "#{result.name} was successfully saved"
      else
        # User was not created
        count = 0
        min_password_length = 10
        max_password_length = 16
        # Check Minimum/Maximum Password Length
        min_password_length - result.password.length > 0 && count += (min_password_length - result.password.length)
        result.password.length - max_password_length > 0 && count += (result.password.length - max_password_length)

        # Check Presence of One Upper Case Letter
        regexUpper = /(.*[A-Z].*)/
        !result.password.match(regexUpper) && count += 1

        # Check Presence of One Lower Case Letter
        regexLower = /(.*[a-z].*)/
        !result.password.match(regexLower) && count += 1

        # Check Presence of One Digit
        regexDigit = /(?=.*\d)/
        !result.password.match(regexDigit) && count += 1

        # Check Presence of Three Consecutive Letters
        regexRepeatingStrings = '([a-zA-Z0-9])\\1\\1+'
        isMatch = result.password.match?(regexRepeatingStrings)

        if isMatch
          @strArr = result.password.split('')
          @strArr.group_by { |v| v }.map do |_k, v|
            count += (v.size / 3) if v.size >= 3
          end
        end
        @result_array << "Change #{count} character of #{result.name}'s password"
      end
    end

    respond_to do |format|
      format.js do
        render template: 'application/result',
               layout: false
      end
    end
  end

  private

  def upload_params
    params.permit(:csv_file, :authenticity_token, :commit)
  end
end
