require 'rails_helper'

feature 'User Skills' do
  let(:logged_user) { FactoryBot.create(:user) }

  before do
    login(logged_user.email, 'dummy-password')
  end

  describe 'Add Skills' do
    scenario 'A user can add his/her skill list' do
      first(:link, logged_user.email).click

      within('form.endorsements') do
        fill_in 'skill_name', with: 'NEW SKILL'
        click_button 'Save'
      end

      expect(page).to have_content('Skill suggested.')
      expect(page).to have_content('NEW SKILL')
    end

    describe 'A user can recommend and can +1 skills on profile pages of other users.' do
      let(:user_with_skills) { FactoryBot.create(:user_with_skills) }

      before(:each) { visit user_path(user_with_skills) }

      scenario 'A user can recomend on profile page of other users' do
        within('form.endorsements') do
          fill_in 'skill_name', with: 'NEW DUMMY SKILL'
          click_button 'Save'
        end

        expect(page).to have_content('Skill suggested.')
        expect(page).to have_content('NEW DUMMY SKILL')
      end

      scenario 'A user can +1 skills on profile page of other users' do
        expect { first(:link, '+').click }.to change {
          Endorsement.where(
            endorser_user_id: logged_user.id,
            endorsed_user_id: user_with_skills.id
          ).count
        }.by(1)
      end
    end
  end

  describe 'Skills order' do
    let(:user) { FactoryBot.create(:user) }
    let(:skill1) { FactoryBot.create(:skill) }
    let(:skill2) { FactoryBot.create(:skill) }
    let(:skill3) { FactoryBot.create(:skill) }
    before do
      10.times do
        FactoryBot.create(
          :endorsement, endorsed_user_id: user.id, skill_id: skill1.id
        )
      end

      7.times do
        FactoryBot.create(
          :endorsement, endorsed_user_id: user.id, skill_id: skill2.id
        )
      end

      6.times do
        FactoryBot.create(
          :endorsement, endorsed_user_id: user.id, skill_id: skill3.id
        )
      end
    end

    scenario 'A skill list is sorted by # of +1s.' do
      visit user_path(user)
      skills = page.all('table.skills tr td:first').map(&:text)
      expect(skills[0]).to eq(skill1.name)
      expect(skills[1]).to eq(skill2.name)
      expect(skills[2]).to eq(skill3.name)
    end
  end
end
