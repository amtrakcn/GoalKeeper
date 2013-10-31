require 'spec_helper'

describe Goal do
  it "should have a valid factory" do
    expect(FactoryGirl.create(:goal)).to be_valid
  end

  subject(:goal) { FactoryGirl.create(:goal) }

  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:user_id)}
  it { should validate_presence_of(:private_goal)}

  it { should allow_mass_assignment_of(:name)}
  it { should allow_mass_assignment_of(:user_id)}
  it { should allow_mass_assignment_of(:details)}
  it { should allow_mass_assignment_of(:private_goal)}

  it { should belong_to(:user) }
end
