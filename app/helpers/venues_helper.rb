# encoding: utf-8
# frozen_string_literal: true
module VenuesHelper
  def action
    if action_name == 'advanced_search'
      :post
    else
      :get
    end
  end

  def display_results_header(count)
    if count > results_limit
      "Showing #{results_limit} results (page #{params.fetch(:page, 1)}) " \
        "out of #{count} total" \
    else
      "Your #{pluralize(count, 'result')}"
    end
  end

  def display_sort_column_headers(search)
    res = \
      venue_column_headers.reduce(String.new) do |string, field|
        string << content_tag('th', sort_link(search, field, {}, method: action))
      end \
      + content_tag('th', 'Menus Count') \
      + content_tag('th', 'Show Menus') \
      + content_tag('th', 'Show Events')

    res.html_safe
  end

  def display_search_results(objects)
    objects.limit(results_limit).reduce(String.new) do |string, object|
      string << content_tag('tr', display_search_results_row(object))
    end.html_safe
  end

  def display_search_results_row(object)
    res = \
      venue_column_fields.reduce(String.new) do |string, field|
        string << content_tag('td', object.send(field))
      end \
      + content_tag('td', object.menus.size) \
      + content_tag('td', link_to('==>', venue_menus_path(object))) \
      + content_tag('td', object.menus.size)

    res .html_safe
  end

  def results_limit
    # max number of search results to display
    10
  end

  def venue_column_headers
    %i(id name created_at updated_at).freeze
  end

  def venue_column_fields
    %i(id name created_at updated_at).freeze
  end

  def display_query_sql(users)
    tag.p('SQL:') + tag.code(users.to_sql)
  end

  def xdisplay_menu_search_results(objects)
    objects.limit(results_limit).reduce(String.new) do |string, object|
      string << content_tag('tr', display_menu_search_results_row(object))
    end.html_safe
  end

  def xdisplay_menu_search_results_row(object)
    res = menu_column_fields.reduce(String.new) do |string, field|
      string << content_tag('td', object.send(field))
    end

    res .html_safe
  end
end
