require 'rails_helper'

RSpec.describe "the '/item_shops/items' #index page" do
  before :each do
    @groggy = ItemShop.create!(
      name: "Groggy's Potions and Knick Knacks",
      city: 'Akros',
      open: 'true',
      num_employees: 3
    )
    @item2 = @groggy.items.create!(
      name: 'Healing Potion',
      quantity: 12,
      price: 50.50,
      consumable: true
    )
    @item1 = @groggy.items.create!(
      name: 'Stick',
      quantity: 26,
      price: 0.02,
      consumable: false
    )
    @item3 = @groggy.items.create!(
      name: 'Greater Healing Potion',
      quantity: 12,
      price: 100.23,
      consumable: true
    )

    @perisophia = ItemShop.create!(
      name: "Perisophia's Scrolls",
      city: 'Meletis',
      open: 'false',
      num_employees: 5
    )
    @item4 = @perisophia.items.create!(
      name: 'Scroll of Minor Illusion',
      quantity: 6,
      price: 100.50,
      consumable: true
    )
    @item6 = @perisophia.items.create!(
      name: 'Wand of Magic Missles',
      quantity: 2,
      price: 1205.35,
      consumable: false
    )
    @item5 = @perisophia.items.create!(
      name: 'Scroll of Spiritual Weapon',
      quantity: 12,
      price: 335.68,
      consumable: true
    )

    visit "/item_shops/#{@groggy.id}/items"
  end
  describe "when I visit 'item_shop_items#index'" do
    it 'displays specific Item data related to ItemShop' do
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item1.quantity)
      expect(page).to have_content(@item1.price)
      expect(page).to have_content(@item1.consumable)
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@item2.quantity)
      expect(page).to have_content(@item2.price)
      expect(page).to have_content(@item2.consumable)
      expect(page).to have_content(@item3.name)
      expect(page).to have_content(@item3.quantity)
      expect(page).to have_content(@item3.price)
      expect(page).to have_content(@item3.consumable)
      expect(page).to_not have_content(@item4)
      expect(page).to_not have_content(@item5)
      expect(page).to_not have_content(@item6)
    end

    it 'displays specific Item data related to ItemShop' do
      visit "/item_shops/#{@perisophia.id}/items"

      expect(page).to have_content(@item4.name)
      expect(page).to have_content(@item4.quantity)
      expect(page).to have_content(@item4.price)
      expect(page).to have_content(@item4.consumable)
      expect(page).to have_content(@item5.name)
      expect(page).to have_content(@item5.quantity)
      expect(page).to have_content(@item5.price)
      expect(page).to have_content(@item5.consumable)
      expect(page).to have_content(@item6.name)
      expect(page).to have_content(@item6.quantity)
      expect(page).to have_content(@item6.price)
      expect(page).to have_content(@item6.consumable)
      expect(page).to_not have_content(@item1)
      expect(page).to_not have_content(@item2)
      expect(page).to_not have_content(@item3)
    end
  end

  describe 'links' do
    it 'page has clickable link that redirects to item_shops#index' do
      click_link 'Item Shops'

      expect(page).to have_link('Item Shops', href: '/item_shops')
      expect(page).to have_current_path('/item_shops')
    end

    it 'page has clickable link that redirects to item#index' do
      click_link 'Items List'

      expect(page).to have_link('Items', href: '/items')
      expect(page).to have_current_path('/items')
    end

    it 'I see a link to order venue' do
      expect(page).to have_link('Sort Alphabetically', href: "/item_shops/#{@groggy.id}/items?sort=asc")
      click_link 'Sort Alphabetically'

      expect(@item3.name).to appear_before(@item1.name)
      expect(@item2.name).to_not appear_before(@item3.name)
    end
  end
end
