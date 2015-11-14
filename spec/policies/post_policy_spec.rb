describe PostPolicy do
  subject { described_class }
  let(:owner_user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:post) { FactoryGirl.create(:post, user: owner_user) }

  permissions :index?, :show?, :create? do
    it "allow access to all users" do
      expect(subject).to permit(other_user, post)
    end
  end

  permissions :update?, :destroy? do
    it "allow access to admin user" do
      expect(subject).to permit(admin, post)
    end

    it "allow access to post owner" do
      expect(subject).to permit(owner_user, post)
    end

    it "deny access if user is not admin or owner" do
      expect(subject).not_to permit(other_user, post)
    end
  end
end
