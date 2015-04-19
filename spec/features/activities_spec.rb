describe 'Activities', js: true do
  let(:user_attributes) do
    {
      email: 'fakeuser@email.com',
      password: 'abc12345',
      username: 'fakeuser'
    }
  end

  let(:goal_attributes) do
    {
      name: 'My Goal',
      description: 'My long description',
      completion_date: 30.days.from_now.to_s
    }
  end

  let(:motivational_quote_double) do
    double(:motivational_quote,
      content: 'text'
    )
  end

  before do
    allow(MotivationalQuote).to receive(:find) { motivational_quote_double }

    visit new_user_registration_path
    fill_in 'Username',              with: user_attributes[:username]
    fill_in 'Email',                 with: user_attributes[:email]
    fill_in 'Password',              with: user_attributes[:password]
    fill_in 'Password confirmation', with: user_attributes[:password]

    click_on 'Sign up'
    # Create account

    fill_in 'Email',    with: user_attributes[:email]
    fill_in 'Password', with: user_attributes[:password]

    click_on 'Log in'
    # Sign in

    visit new_goal_path

    fill_in 'Name',            with: goal_attributes[:name]
    fill_in 'Description',     with: goal_attributes[:description]
    fill_in 'Completion Date', with: goal_attributes[:completion_date]

    click_on 'Create Goal'
    # Create goal
  end

  describe 'dynamic form' do

    it 'does not display the form by default' do
      expect(page).not_to have_selector('form#new_activity')
    end

    context 'when clicking on "Add Activity"' do
      before do
        click_on 'Add Activity'
      end

      it 'displays the form' do
        expect(page).to have_selector('form#new_activity')
      end
    end
  end
end
