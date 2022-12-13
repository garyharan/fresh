module GroupsHelper
  def public_group_url(group)
    "#{root_url}#{group.id}"
  end
end
