defmodule Venieri.Archives.Media do
  @moduledoc """
  The Archives context.
  """
  require Logger

  import Ecto.Query, warn: false
  alias Venieri.Repo

  alias Venieri.Archives.Models.Media, as: MediaModel

  @doc """
  Returns the list of media.

  ## Examples

      iex> list()
      [%Media{}, ...]

  """
  def list do
    Repo.all(MediaModel)
    # |>     dbg(label: "list")
  end

  @doc """
  Gets a single media.

  Raises `Ecto.NoResultsError` if the Media does not exist.

  ## Examples

      iex> get!(123)
      %Media{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(MediaModel, id)

  @doc """
  Creates a media.

  ## Examples

      iex> create(%{field: value})
      {:ok, %Media{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    %MediaModel{}
    |> MediaModel.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a media.

  ## Examples

      iex> update(media, %{field: new_value})
      {:ok, %Media{}}

      iex> update(media, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update(%MediaModel{} = media, attrs) do
    media
    |> MediaModel.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a media.

  ## Examples

      iex> delete(media)
      {:ok, %Media{}}

      iex> delete(media)
      {:error, %Ecto.Changeset{}}

  """
  def delete(%MediaModel{} = media) do
    Repo.delete(media)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking media changes.

  ## Examples

      iex> change(media)
      %Ecto.Changeset{data: %Media{}}

  """
  def change(%MediaModel{} = media, attrs \\ %{}) do
    MediaModel.changeset(media, attrs)
  end

  # def process_upload(%MediaModel{} = item, entry, %{path: _path} = meta) do
  #   {:ok, media} =
  #     item
  #     |> __MODULE__.update(prepare_upload(entry, meta))

  #   {:ok, file_url(media.original_file)}
  # end

  def process_upload(%MediaModel{} = media, temp_file) do
    file_name = media.original_file
    dest = Path.join([full_upload_dir(), file_name])
    File.cp!(temp_file, dest)
    Logger.info("File.cp!(#{temp_file}, #{dest})")
    %{
      "image_width" => image_width,
      "image_height" => image_height,
      "file_type" => file_type,
      "mime_type" => _mime_type,
    } = meta_data = ImageHelpers.info!(dest)
    media
    |> __MODULE__.update(%{
      meta_data: meta_data,
      type: file_type,
      width: String.to_integer(image_width),
      height: String.to_integer(image_height)
    })
    |> case do
      {:ok, media} -> media |> tap(&save_to_s3/1) |> tap(&process/1)
      {:error, changeset} -> Logger.error("Error updating media metadata: #{inspect(changeset)}")
    end
  end

  def process(%MediaModel{} = item) do
    ImageProcessor.new(%{
      "action" => "process",
      "media_id" => item.id
    })
    |> Oban.insert()
  end

  def normalize(%MediaModel{} = item) do
    ImageHelpers.normalize(get_upload_file(item), get_media_path())
  end

  def process_upload(_item, entry, %{path: _path} = meta) do
    params =
      prepare_upload(entry, meta)
      |> Map.put(:original_file, file_name(entry))

    {:ok, media} =
      __MODULE__.create(params)

    {:ok, file_url(media.original_file)}
    media
  end

  def prepare_upload(entry, %{path: path} = _meta), do: prepare_upload(entry, path)

  def prepare_upload(entry, path) do
    file_name = file_name(entry)
    dest = Path.join([:code.priv_dir(:venieri), "static", upload_dir(), file_name])
    File.mkdir_p!(Path.dirname(dest))
    File.cp!(path, dest)
    Logger.info("File.cp!(#{path}, #{dest})")
    %{
      "image_width" => image_width,
      "image_height" => image_height,
      "file_type" => file_type,
      "mime_type" => _mime_type
    } = meta_data = ImageHelpers.info!(dest)

    %{
      meta_data: meta_data,
      type: file_type,
      width: String.to_integer(image_width),
      height: String.to_integer(image_height)
    }
  end

  defp file_url(file_name) do
    static_path = Path.join([upload_dir(), file_name])
    Phoenix.VerifiedRoutes.static_url(VenieriWeb.Endpoint, "/" <> static_path)
  end

  defp file_name(entry) do
    [ext | _] = MIME.extensions(entry.client_type)
    entry.uuid <> "." <> ext
  end

  def get_upload_file_path(uploaded_file) do
    root = :code.priv_dir(:venieri)

    Path.join([
      root,
      Application.fetch_env!(:venieri, :uploads)[:upload_path],
      "media",
      uploaded_file
    ])
  end

  def save_to_s3(%MediaModel{} = media) do
    ImageProcessor.new(%{
      "action" => "upload_s3",
      "media_id" => media.id,
      "src" => get_upload_file_path(media.original_file),
      "bucket" => "venieri.com",
      "key" => Path.join(["uploads","media", media.original_file])
    })
    |> Oban.insert()
  end


  def upload_dir, do: Path.join(["uploads", "media"])

  def full_upload_dir do
    root = :code.priv_dir(:venieri)
    Path.join([root, Application.fetch_env!(:venieri, :uploads)[:upload_path], "media"])
  end

  def full_media_dir do
    root = :code.priv_dir(:venieri)
    Path.join([root, Application.fetch_env!(:venieri, :uploads)[:media_path], "media"])
  end

  def get_upload_file_path(%MediaModel{} = media) do
    get_upload_file_path(media.original_file)
  end

  def get_upload_file_path(uploaded_file) do
    root = :code.priv_dir(:venieri)

    Path.join([
      root,
      Application.fetch_env!(:venieri, :uploads)[:upload_path],
      "media",
      uploaded_file
    ])
  end

  def get_upload_file(%MediaModel{} = media) do
    root = :code.priv_dir(:venieri)

    Path.join([
      root,
      Application.fetch_env!(:venieri, :uploads)[:upload_path],
      "media",
      media.original_file
    ])
  end

  def get_upload_file(uploaded_file) do
    root = :code.priv_dir(:venieri)

    Path.join([
      root,
      Application.fetch_env!(:venieri, :uploads)[:upload_path],
      "media",
      uploaded_file
    ])
  end

  def get_media_file(%MediaModel{} = media, ext \\ "avif") do
    get_media_file(media.slug, ext)
  end

  def get_media_file(slug, ext) do
    root = :code.priv_dir(:venieri)
    media_path = Path.join([root, Application.fetch_env!(:venieri, :uploads)[:media_path]])
    if File.exists?(media_path) != true, do: File.mkdir_p(media_path)
    Path.join([media_path, "#{slug}.#{ext}"])
  end

  def get_media_path() do
    root = :code.priv_dir(:venieri)
    media_path = Path.join([root, Application.fetch_env!(:venieri, :uploads)[:media_path]])
  end

  def url(%MediaModel{} = media) do
    url(media, nil)
  end

  def url(%MediaModel{} = media, width) do
    with_postfix =
      if width == nil do
        ""
      else
        "-#{width}"
      end

    if media.meta_data != nil do
      small_image = "#{media.slug}#{with_postfix}.avif"

      Phoenix.VerifiedRoutes.static_url(
        VenieriWeb.Endpoint,
        "/" <> Path.join(["media", small_image])
      )
    else
      Phoenix.VerifiedRoutes.static_url(
        VenieriWeb.Endpoint,
        "/" <> Path.join(["uploads", "media", media.original_file])
      )
    end
  end


  def is_vertical?(%MediaModel{} = media) do
    media.width < media.height
  end

  def src_for(%MediaModel{} = media, width \\ nil) do
    if media.type == "image" do
      with_postfix =
        if width == nil do
          ""
        else
          "-#{width}"
        end

      if media.meta_data != nil do
        small_image = "#{media.slug}#{with_postfix}.avif"

        Phoenix.VerifiedRoutes.static_url(
          VenieriWeb.Endpoint,
          "/" <> Path.join(["media", small_image])
        )
      else
        Phoenix.VerifiedRoutes.static_url(
          VenieriWeb.Endpoint,
          "/" <> Path.join(["uploads", "media", media.original_file])
        )
      end
    else
      media.video_uri
    end
  end

end
