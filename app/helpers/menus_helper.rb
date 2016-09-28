# frozen_string_literal: true
module MenusHelper
  def action
    if action_name == 'advanced_search'
      :post
    else
      :get
    end
  end

  def display_menu_results_header(count)
    if count > results_limit
      "Showing #{results_limit} results (page #{params.fetch(:page, 1)}) " \
        "out of #{count} total" \
    else
      "Your #{pluralize(count, 'result')}"
    end
  end

  def display_menu_sort_column_headers(search)
    res = menu_column_headers.reduce(String.new) do |string, field|
      string << (content_tag('th', sort_link(search, field, {}, method: action)))
    end

    res.html_safe
  end

  def display_menu_search_results(objects)
    objects.limit(results_limit).reduce(String.new) do |string, object|
      string << (content_tag('tr', display_menu_search_results_row(object)))
    end.html_safe
  end

  def display_menu_search_results_row(object)
    res = menu_column_fields.reduce(String.new) do |string, field|
      string << (content_tag('td', object.send(field)))
    end

    res .html_safe
  end

  def results_limit
    # max number of search results to display
    10
  end

  def menu_column_headers
    %i(id notes sheduled_on created_at updated_at).freeze
  end

  def menu_column_fields
    %i(id notes sheduled_on created_at updated_at).freeze
  end

  def display_query_sql(object)
    tag.p('SQL:') + tag.code(object.to_sql)
  end


end
