# frozen_string_literal: true
json.menus @search.result do |menu|
  json.extract! menu,
    :id,
    :call_number,
    :sheduled_on,
    :dishes_count,
    :keywords

  json.place  menu.place.name
  json.event  menu.event.name

  json.currency do |c|
    json.name      menu.currency
    json.symbol    menu.currency_symbol
  end

  json.venues menu.venues, :name

end
