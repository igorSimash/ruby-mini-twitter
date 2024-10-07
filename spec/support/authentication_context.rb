RSpec.shared_context :authenticated_user do
  let(:user) { User.create(username: "usernameex", email: "user@example.com", password: "password123") }

  before do
    sign_in user
  end
end
