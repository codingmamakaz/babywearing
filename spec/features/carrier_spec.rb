RSpec.describe 'Carrier' do
  fixtures :categories
  let(:category) { categories(:category) }
  fixtures :locations
  let(:location) { locations(:location) }
  fixtures :carriers
  let(:carrier) { carriers(:carrier) }
  fixtures :users
  let(:user) { users(:user) }

  before do
    carrier.update_attributes(location_id: location.id, category_id: category.id)

    visit "organizations/inventory"
    sign_in user
  end

  scenario 'SHOW' do
    visit carriers_path
    click_link carrier.name

    expect(page).to have_content('test carrier')
    expect(page).to have_content('babywearing')
    expect(page).to have_content('test model')
  end

  scenario 'EDIT with all required fields' do
    visit edit_carrier_path(carrier.id)

    fill_in 'Name', with: 'Updated Name'
    fill_in 'Model', with: 'Updated Model'
    click_on 'Update Carrier'

    expect(page).to have_content('Updated Name')
    expect(page).to have_content('Updated Model')
  end

  scenario 'EDIT without any required fields' do
    visit edit_carrier_path(carrier.id)

    fill_in 'Name', with: nil
    fill_in 'Item', with: nil
    click_on 'Update Carrier'

    expect(page).to have_content('Name can\'t be blank')
    expect(page).to have_content('Item can\'t be blank')
  end

  scenario 'DESTROY' do
    visit carrier_path(carrier.id)

    click_on 'Delete'

    expect(page).to have_content('Carrier successfully destroyed')
  end

  scenario 'CREATE with all required fields' do
    visit new_carrier_path
    fill_in 'Name', with: 'Test Name'
    fill_in 'Item', with: 9
    fill_in 'Manufacturer', with: 'Test Manufacturer'
    fill_in 'Model', with: 'Test Model'
    fill_in 'Color', with: 'White'
    find('#carrier_category_id').find(:option, category.name).select_option

    click_on 'Create Carrier'

    expect(page).to have_content('Carrier successfully created')
  end

  scenario 'CREATE with duplicated item_id' do
    visit new_carrier_path
    fill_in 'Item', with: carrier.item_id

    click_on 'Create Carrier'

    expect(page).to have_content('Item ID has already been taken')
  end

  scenario 'CREATE without required fields' do
    visit new_carrier_path(carrier.id)

    click_on 'Create Carrier'

    expect(page).to have_content('Name can\'t be blank')
    expect(page).to have_content('Item can\'t be blank')
  end
end
