defmodule Pairmotron.ProjectView do
  @moduledoc false
  use Pairmotron.Web, :view

  @spec format_group(nil | Types.group) :: binary()
  def format_group(nil), do: "(none)"
  def format_group(%Pairmotron.Group{name: name}), do: name

  @doc """
  True if the given user is the creator of the project or is the owner of the
  group associated with the project. False otherwise.

  Expects the :group association on project to be preloaded or else the function
  will error.
  """
  @spec user_can_edit_project?(Types.project, Types.user) :: boolean()
  def user_can_edit_project?(project, user) do
    project.created_by_id == user.id or project.group.owner_id == user.id
  end
end
