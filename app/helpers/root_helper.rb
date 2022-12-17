module RootHelper
  def error_messages_for(record, attribute)
    return "" unless record.errors[attribute].any?

    content_tag :div, class: "text-red-500 text-sm" do
      record.errors[attribute].join(", ")
    end
  end
end
