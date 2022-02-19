require 'rails_helper'

RSpec.feature 'Website features', js: true, type: :feature do
  scenario 'User sees a text and form to upload CSV file' do
    visit '/'
    expect(page).to have_text('Please upload a csv file of users')
  end

  scenario 'User uploads csv file and sees result' do
    visit '/'
    expect(page).to have_selector 'input'
    attach_file 'csv_file', "#{Rails.root}/spec/files/users.csv"
    click_on 'Upload CSV'

    expect(page).to have_text('Muhammad was successfully saved')
    expect(page).to have_text("Change 1 character of Maria Turing's password")
    expect(page).to have_text("Change 4 character of Isabella's password")
    expect(page).to have_text("Change 5 character of Axel's password")
  end
end
