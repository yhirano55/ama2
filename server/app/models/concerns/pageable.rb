module Pageable
  extend ActiveSupport::Concern

  FIRST_PAGE = 1

  included do
    attr_accessor :data, :context
  end

  def links
    return {} unless paginate?

    {
      self:  location_url,
      first: first_page_url,
      prev:  prev_page_url,
      next:  next_page_url,
      last:  last_page_url,
    }
  end

  private

    def paginate?
      %i[current_page total_pages limit_value].all? do |name|
        data.respond_to?(name)
      end
    end

    def location_url
      url_for_page(data.current_page)
    end

    def first_page_url
      url_for_page(1)
    end

    def last_page_url
      if data.total_pages == 0
        url_for_page(FIRST_PAGE)
      else
        url_for_page(data.total_pages)
      end
    end

    def prev_page_url
      return nil if data.current_page == FIRST_PAGE

      url_for_page(data.current_page - FIRST_PAGE)
    end

    def next_page_url
      return nil if data.total_pages == 0 || data.current_page == data.total_pages

      url_for_page(data.next_page)
    end

    def url_for_page(number)
      params = query_parameters.dup
      params[:page] = number
      params[:per] = limit_value
      "#{request_url}?#{params.to_query}"
    end

    def request_url
      @request_url ||= "#{context.base_url}#{context.path}"
    end

    def query_parameters
      @query_parameters ||= context.query_parameters
    end

    def limit_value
      @limit_value ||= data.limit_value
    end
end
