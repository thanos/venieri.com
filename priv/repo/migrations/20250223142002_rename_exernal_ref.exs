defmodule Venieri.Repo.Migrations.RenameExernalRef do
  use Ecto.Migration

  def change do
    rename table(:archives_media), :exernal_ref, to: :video_uri
  end
end
