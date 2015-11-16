describe UserPolicy do
  subject { described_class }
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }

  permissions :index?, :show? do
    it "allow access to all users" do
      expect(subject).to permit(other_user, user)
    end
  end

  permissions :update?, :destroy? do
    it "allow access to admin user" do
      expect(subject).to permit(admin, user)
    end

    it "allow access to user owner" do
      expect(subject).to permit(user, user)
    end

    it "deny access if user is not admin or owner" do
      expect(subject).not_to permit(other_user, user)
    end
  end
end
