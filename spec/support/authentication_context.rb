RSpec.shared_context :authenticated_user do
  let(:user) { create(:user) }

  before do
    sign_in user
  end
end
