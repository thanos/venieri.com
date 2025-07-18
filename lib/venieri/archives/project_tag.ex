defmodule Venieri.Archives.ProjectTag do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  alias Venieri.Archives.Project
  alias Venieri.Archives.Tag

  schema "projects_tags" do
    belongs_to(:project, Project, on_replace: :delete)
    belongs_to(:tag, Tag, on_replace: :delete)
  end

  @required_fields ~w[project_id tag_id]a

  @doc false
  def changeset(project_tag, attrs) do
    project_tag
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:project_id)
    |> foreign_key_constraint(:tag_id)
  end
end
