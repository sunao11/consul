require "rails_helper"

describe "SDG Relations", :js do
  before do
    login_as(create(:administrator).user)
    Setting["feature.sdg"] = true
    Setting["sdg.process.budgets"] = true
    Setting["sdg.process.debates"] = true
    Setting["sdg.process.legislation"] = true
    Setting["sdg.process.polls"] = true
    Setting["sdg.process.proposals"] = true
  end

  scenario "navigation" do
    visit sdg_management_root_path

    within("#side_menu") { click_link "Participatory budgets" }

    expect(page).to have_current_path "/sdg_management/budget/investments"
    expect(page).to have_css "h2", exact_text: "Participatory budgets"

    within("#side_menu") { click_link "Debates" }

    expect(page).to have_current_path "/sdg_management/debates"
    expect(page).to have_css "h2", exact_text: "Debates"

    within("#side_menu") { click_link "Collaborative legislation" }

    expect(page).to have_current_path "/sdg_management/legislation/processes"
    expect(page).to have_css "h2", exact_text: "Collaborative legislation"

    within("#side_menu") { click_link "Polls" }

    expect(page).to have_current_path "/sdg_management/polls"
    expect(page).to have_css "h2", exact_text: "Polls"

    within("#side_menu") { click_link "Proposals" }

    expect(page).to have_current_path "/sdg_management/proposals"
    expect(page).to have_css "h2", exact_text: "Proposals"
  end

  describe "Index" do
    scenario "list records for the current model" do
      create(:debate, title: "I'm a debate")
      create(:proposal, title: "And I'm a proposal")

      visit sdg_management_debates_path

      expect(page).to have_text "I'm a debate"
      expect(page).not_to have_text "I'm a proposal"

      visit sdg_management_proposals_path

      expect(page).to have_text "I'm a proposal"
      expect(page).not_to have_text "I'm a debate"
    end

    scenario "list goals and target for all records" do
      redistribute = create(:proposal, title: "Resources distribution")
      redistribute.sdg_goals = [SDG::Goal[1]]
      redistribute.sdg_targets = [SDG::Target["1.1"]]

      treatment = create(:proposal, title: "Treatment system")
      treatment.sdg_goals = [SDG::Goal[6]]
      treatment.sdg_targets = [SDG::Target["6.1"], SDG::Target["6.2"]]

      visit sdg_management_proposals_path

      within("tr", text: "Resources distribution") do
        expect(page).to have_content "1.1"
      end

      within("tr", text: "Treatment system") do
        expect(page).to have_content "6.1, 6.2"
      end
    end

    scenario "shows link to edit a record" do
      create(:budget_investment, title: "Build a hospital")

      visit sdg_management_budget_investments_path

      within("tr", text: "Build a hospital") do
        click_link "Manage goals and targets"
      end

      expect(page).to have_css "h2", exact_text: "Build a hospital"
    end

    describe "search" do
      scenario "search by terms" do
        create(:poll, name: "Internet speech freedom")
        create(:poll, name: "SDG interest")

        visit sdg_management_polls_path

        fill_in "search", with: "speech"
        click_button "Search"

        expect(page).to have_content "Internet speech freedom"
        expect(page).not_to have_content "SDG interest"
      end

      scenario "goal filter" do
        create(:budget_investment, title: "School", sdg_goals: [SDG::Goal[4]])
        create(:budget_investment, title: "Hospital", sdg_goals: [SDG::Goal[3]])

        visit sdg_management_budget_investments_path
        select "4. Quality Education", from: "goal_code"
        click_button "Search"

        expect(page).to have_content "School"
        expect(page).not_to have_content "Hospital"
      end
    end

    scenario "target filter" do
      create(:budget_investment, title: "School", sdg_targets: [SDG::Target[4.1]])
      create(:budget_investment, title: "Preschool", sdg_targets: [SDG::Target[4.2]])

      visit sdg_management_budget_investments_path
      select "4.1", from: "target_code"
      click_button "Search"

      expect(page).to have_content "School"
      expect(page).not_to have_content "Preschool"
    end
  end

  describe "Edit" do
    scenario "allows changing the targets" do
      process = create(:legislation_process, title: "SDG process")
      process.sdg_targets = [SDG::Target["3.3"]]

      visit sdg_management_edit_legislation_process_path(process)
      find(:css, ".sdg-related-list-selector-input").set("1.2,")
      click_button "Update Process"

      within("tr", text: "SDG process") do
        expect(page).to have_css "td", exact_text: "1.2"
      end
    end
  end
end
