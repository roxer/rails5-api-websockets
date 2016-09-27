module PlacesHelper
  def action
    if action_name == 'advanced_search'
      :post
    else
      :get
    end
  end

  def display_place_results_header(count)
    if count > results_limit
      "Showing #{results_limit} results (page #{params.fetch(:page, 1)}) " \
        "out of #{count} total" \
    else
      "Your #{pluralize(count, 'result')}"
    end
  end

  # REVIEW table headers
  def display_place_sort_column_headers(search)
    res = event_column_headers.reduce(String.new) do |string, field|
            string << (content_tag('th', sort_link(search, field, {}, method: action)))
          end \
          + content_tag('th', 'Menus Count') \
          + content_tag('th', 'Show Menus')

    res.html_safe
  end

  def display_place_search_results(objects)
    objects.limit(results_limit).reduce(String.new) do |string, object|
      string << (content_tag('tr', display_place_search_results_row(object)))
    end.html_safe
  end

  # REVIEW table row
  def display_place_search_results_row(object)
    res = event_column_fields.reduce(String.new) do |string, field|
            string << (content_tag('td', object.send(field)))
          end \
          + content_tag('td', content_tag('b', object.menus.size)) \
          + content_tag('td', link_to('==>', place_menus_path(object)))

    res.html_safe
  end

  def results_limit
    # max number of search results to display
    10
  end

  def place_column_headers
    %i(id name created_at updated_at).freeze
  end

  def place_column_fields
    %i(id name created_at updated_at).freeze
  end

  def display_query_sql(users)
    tag.p('SQL:') + tag.code(users.to_sql)
  end
end
