module CardsHelper
  def cards_select_options(kind)
    Card::KINDS[kind.to_sym].map { |k| [t(k), k] }
  end
end
