module ValidUserRequestHelper
    # Define a method which signs in as a valid user.
    def sign_in_user
        # ASk factory girl to generate a valid user for us.
        @user ||= FactoryGirl.create :user
sign_in @user
    end
end

# Configure these to modules as helpers in the appropriate tests.
# RSpec.configure do |config|
#     # Include the help for the request specs.
#     config.include ValidUserRequestHelper, :type => :request
# end