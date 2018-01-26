module ValidUserRequestHelper
  def sign_in_user
    @user ||= FactoryBot.create :user
    sign_in @user
  end
end
