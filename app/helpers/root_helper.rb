module RootHelper
  def error_messages_for(record, attribute)
    return "" unless record.errors[attribute].any?

    content_tag :span, class: "text-red-500 text-sm inline" do
      "(" + record.errors[attribute].join(", ") + ")"
    end
  end
end
