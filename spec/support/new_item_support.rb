module NewItemSupport
  def new_item(item)
    attach_file('item[image]', @image_path, make_visible: true)
    fill_in 'item[name]', with: @item.name
    fill_in 'item[info]', with: @item.info
    select @item.category.name, from: 'item[category_id]'
    select @item.status.name, from: 'item[status_id]'
    select @item.shipping_cost.name, from: 'item[shipping_cost_id]'
    select @item.prefecture.name, from: 'item[prefecture_id]'
    select @item.ship_date.name, from: 'item[ship_date_id]'
    fill_in 'item[price]', with: @item.price
  end
end