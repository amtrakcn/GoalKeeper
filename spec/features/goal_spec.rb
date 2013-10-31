require 'spec_helper'

describe "creating goal" do
  it "should have a create goal page" do
    sign_up("ned", "ilovecat")
    visit new_goal_url
    expect(page).to have_content("Add New Goal")
  end

  it "should be able to see the goal created" do
    create_goal
    expect(page).to have_content("lose 10 lbs in 1 day")
  end
end

describe "editing goal" do
  it "should have an edit goal page" do
    create_goal
    click_button("Edit")
    expect(page).to have_content("Editing lose 10 lbs")
  end

  it "should save the editing result" do
    create_goal
    click_button("Edit")
    fill_in "goal_name", with: "lose another 10 lbs"
    click_button("Edit")
    expect(page).to have_content("lose another 10 lbs")
  end
end

describe "deleting goal" do
  it "should delete goal on clicking delete button" do
    create_goal
    click_button("Delete")
    expect(page).not_to have_content("lose 10 lbs")
  end
end

describe "Visibility" do
  it "able to see public goals when not logged in" do
    create_public_goal
    click_button("Log Out")
    visit goals_url
    expect(page).to have_content("implement rails lite")
  end

  it "not ablt to see private goals when not logged in" do
    create_goal
    click_button("Log Out")
    visit goals_url
    expect(page).not_to have_content("lose 10 lbs")
  end

  it "able to see both public goals and private goals when logged in" do
    create_public_goal
    visit new_goal_url
    fill_in "Goal name", with: "lose 10 lbs"
    fill_in "Details", with: "lose 10 lbs in 1 day"
    click_button "Add New Goal"
    visit goals_url
    expect(page).to have_content("implement rails lite")
    expect(page).to have_content("lose 10 lbs")
  end
end

