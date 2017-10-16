module WikisHelper
  def authorize_create
    current_user.admin? || current_user.premium?
  end

  def authorize_update
    current_user
  end

  def authorize_delete
    current_user == @wiki.user || current_user.admin?
  end

  def markdown(body)
    RedCarpet::Markdown.new(RedCarpet::Render::HTML, tables: true, autolink: true, underline: true)
  end
end
