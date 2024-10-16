module ApplicationHelper
  def format_body(body)
    body.gsub(/\n{2,}/, "\n\n")
  end

  def flash_class(type)
    {
      notice: "bg-green-400/50",
      alert: "bg-red-500/70",
      warning: "bg-red-400/50"
    }[type.to_sym] || "bg-gray-400/50"
  end
end
