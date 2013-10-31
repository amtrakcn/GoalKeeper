require 'spec_helper'

describe User do
  it "has a valid factory method" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  subject(:user) { FactoryGirl.create(:user) }

  it { should allow_mass_assignment_of(:username)}
  it { should allow_mass_assignment_of(:password)}
  it { should_not allow_mass_assignment_of(:password_digest)}
  it { should_not allow_mass_assignment_of(:session_token)}


  it { should validate_presence_of(:username)}
  it { should validate_presence_of(:password_digest)}
  it { should validate_uniqueness_of(:username)}


  it "does not store the password in the databse" do
    expect(User.find(user.id).password).to be_nil
  end

  it "can check whether a given password is valid" do
    expect(FactoryGirl.build(:user, :password => "short")).not_to be_valid
  end

  it "can check a given password against the stored hash" do
    expect(user.is_password?('asdf')).to be_false
    expect(user.is_password?(user.password)).to be_true
  end

  it "finds a user with given credentials" do
    expect(User.find_by_credentials(user.username, user.password)).to eq(user)
  end

  it "resets session token" do
    expect(user.session_token).not_to eq(user.reset_token!)
  end

  it { should have_many(:goals) }
end
