module ApplicationHelper
  def format_body(body)
    body.gsub(/\n{2,}/, "\n\n")
  end
end
