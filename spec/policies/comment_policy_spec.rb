describe CommentPolicy do
  subject { described_class }
  let(:owner_user) { FactoryGirl.create(:user) }
  let(:post_owner_user) {FactoryGirl.create(:user)}
  let(:other_user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:post) { FactoryGirl.create(:post, user: post_owner_user) }
  let(:comment) { FactoryGirl.create(:comment, post: post, user: owner_user) }

  permissions :index?, :show?, :create? do
    it "allow access to all users" do
      expect(subject).to permit(other_user, comment)
    end
  end

  permissions :update?, :destroy? do
    it "allow access to admin user" do
      expect(subject).to permit(admin, comment)
    end

    it "allow access to post owner" do
      expect(subject).to permit(post_owner_user, comment)
    end

     it "allow access to comment owner" do
      expect(subject).to permit(owner_user, comment)
    end

    it "deny access if user is not admin or owner or post_owner" do
      expect(subject).not_to permit(other_user, comment)
    end
  end
end

