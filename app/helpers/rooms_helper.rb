module RoomsHelper
  def room_title(current_user, room)
    room
      .profiles
      .reject { |p| p.user == current_user }
      .map(&:display_name)
      .to_sentence
  end
end
