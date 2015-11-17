require 'rails_helper'

describe User, type: :model do

  let(:email) { 'example@domain.com' }
  let(:password) { 'password' }
  it { is_expected.to have_many(:posts).dependent(:destroy) }
  it { is_expected.to have_many(:comments).dependent(:destroy) }
  it { is_expected.to have_and_belong_to_many(:roles) }
  it { is_expected.to validate_presence_of(:firstname) }
  it { is_expected.to validate_presence_of(:lastname) }
  it { is_expected.to validate_uniqueness_of(:email) }

  context "validations" do
    let(:user) { FactoryGirl.build(:user) }
    subject { user }

    before :each do
      expect be_valid
    end

    context "on new user" do
      it "should be saved" do
        subject.save!
      end

      it "expected email to be in proper format" do
        subject.email = 'wrongformat@'
        expect(subject).not_to be_valid
        subject.email = email
        expect(subject).to be_valid
      end

      context "password" do
        it "has not to be too short" do
          subject.password = subject.password_confirmation = 'abc'
          expect(subject).not_to be_valid
          subject.password = subject.password_confirmation = password
          expect(subject).to be_valid
        end

        it "should not be empty" do
          subject.password = subject.password_confirmation = ""
          expect(subject).not_to be_valid
          subject.password = subject.password_confirmation = password
          expect(subject).to be_valid
        end

        it "confirmation expected to match" do
          subject.password_confirmation = "another_password"
          expect(subject).not_to be_valid
          subject.password_confirmation = password
          expect(subject).to be_valid
        end
      end
    end

    context "existing user" do 
      let!(:user) { FactoryGirl.create(:user) }
      subject { user }

      it "have to be valid" do
        expect(subject).to be_valid
      end

      it "password_digest is changed after password update and user is valid" do
        expect{ subject.update_attributes(password: "password", password_confirmation: "password") }.to change{ subject.password_digest }
        expect(subject).to be_valid
      end
    end
  end

  context "dynamic role matcher" do
    let(:user) { FactoryGirl.build(:user) }

    context "simple user" do
      it "should response to is_admin? with false" do
        expect(user.is_admin?).to be_falsey
      end
    end

    context "admin user" do
      let(:admin_role) { FactoryGirl.create(:role, :admin) }
      before :each do
        user.roles << admin_role
      end
      it "should response to is_admin? with true" do
        expect(user.is_admin?).to be_truthy
      end

      it "should response to is_chuck_noris_or_admin? with true" do
        expect(user.is_chuck_noris_or_admin?).to be_truthy
      end
    end
  end
end
