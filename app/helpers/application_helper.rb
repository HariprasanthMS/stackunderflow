module ApplicationHelper
  # add_flash_types :info, :error, :warning

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Sample App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end  
end
