defmodule VenieriWeb.AdminMediaLive do
  alias Venieri.Archives.Media

  use Backpex.LiveResource,
    adapter_config: [
      schema: Venieri.Archives.Models.Media,
      repo: Venieri.Repo,
      update_changeset: &Venieri.Archives.Models.Media.changeset/3,
      create_changeset: &Venieri.Archives.Models.Media.changeset/3
    ],
    layout: {VenieriWeb.Layouts, :admin},
    pubsub: [
      name: Venieri.PubSub,
      topic: "media",
      event_prefix: "media_"
    ],
    fluid?: true

  require Logger

  @impl Backpex.LiveResource
  def singular_name, do: "Media"

  @impl Backpex.LiveResource
  def plural_name, do: "Media"

  @impl Backpex.LiveResource
  def item_actions(default_actions) do
    default_actions
    |> Enum.concat(process: %{module: VenieriWeb.Admin.ItemActions.Process})
  end

  # def render_resource_slot(assigns, :index, :before_main) do
  #   ~H'<p><img class="h-10 w-auto"  src={file_url(@value)} /><br />{@value}</p>'
  # end

  def render_resource_slot(assigns, :show, :before_main) do
    ~H"""
    <div>
      <img src={file_url(@item)} />
    </div>
    """
  end

  @impl Backpex.LiveResource
  def fields do
    [
      id: %{
        module: Backpex.Fields.Text,
        label: "ID",
        readonly: true
      },
      original_file: %{
        module: Backpex.Fields.Upload,
        label: "Upload file",
        upload_key: :original_file,
        accept: ~w(.jpg .jpeg .png .tif .webp .avif .heic .heif ),
        searchable: true,
        max_file_size: 3_000_000_000,
        put_upload_change: &put_upload_change/6,
        consume_upload: &consume_upload/4,
        remove_uploads: &remove_uploads/3,
        list_existing_files: &list_existing_files/1,
        render: fn
          %{value: value} = assigns when value == "" or is_nil(value) ->
            ~H"<p><%= Backpex.HTML.pretty_value(@value) %></p>"

          assigns ->
            ~H'<p>
              <a href={"/uploads/#{@item.original_file}"}>
                <img class="h-10 w-auto"  src={file_url(@item)} />
              </a><br />
              {@value}
              </p>
              '
        end
      },
      slug: %{
        module: Backpex.Fields.Text,
        label: "Slug",
        readonly: true,
        searchable: true
      },
      caption: %{
        module: Backpex.Fields.Text,
        label: "Caption",
        searchable: true
      },
      type: %{
        module: Backpex.Fields.Text,
        label: "Type",
        readonly: true
      },
      width: %{
        module: Backpex.Fields.Text,
        label: "Width",
        readonly: true
      },
      height: %{
        module: Backpex.Fields.Text,
        label: "Height",
        readonly: true
      },
      old_id: %{
        module: Backpex.Fields.Text,
        label: "Old ID",
        readonly: true
      },
      video_uri: %{
        module: Backpex.Fields.Text,
        label: "External reference",
        readonly: true
      },
      meta_data: %{
        module: Backpex.Fields.Map,
        label: "Meta data",
        rows: 10,
        except: [:index],
        readonly: true
      }
    ]
  end

  defp list_existing_files(%{original_file: original_file} = _item)
       when original_file != "" and not is_nil(original_file),
       do: [original_file]

  defp list_existing_files(_item), do: []

  def put_upload_change(_socket, params, item, uploaded_entries, removed_entries, action) do
    existing_files = list_existing_files(item) -- removed_entries

    new_entries =
      case action do
        :validate ->
          elem(uploaded_entries, 1)

        :insert ->
          elem(uploaded_entries, 0)
      end

    files = existing_files ++ Enum.map(new_entries, fn entry -> file_name(entry) end)

    case files do
      [file] ->
        params
        |> Map.put("original_file", file)

      # |> Map.put("caption", "too_many_files")
      [_file | _other_files] ->
        Map.put(params, "original_file", "too_many_files")

      [] ->
        Map.put(params, "original_file", "")
    end
  end

  defp consume_upload(_socket, item, %{path: path} = meta, entry) do
    {:ok,
     Media.process_upload(item, path)
     |> Media.url(480)
    }
  end

  defp remove_uploads(_socket, _item, removed_entries) do
    # for file <- removed_entries do
    #   path = Path.join([:code.priv_dir(:venieri), "static", upload_dir(), file])
    #   File.rm!(path)
    # end
  end

  defp file_url(media) do
    # dbg(media)
    Media.url(media, 480)
  end

  defp file_name(entry) do
    [ext | _] = MIME.extensions(entry.client_type)
    slug = Slug.slugify(Path.rootname(entry.client_name))
    {:ok, id} = Snowflake.next_id()
    uuid = Slug.slugify(id |> Integer.to_string(36))
    "#{slug}-#{uuid}.#{ext}"
  end

  defp upload_dir, do: Path.join(["uploads", "media"])

  def handle_event("save", what, socket) do
    # dbg(what)
    # dbg(socket.assigns)
    {:noreply, socket}
  end

  def handle_info({"media_updated", item}, socket) do
    Logger.error("media_updated #{inspect(item)}")
    {:noreply, socket}
  end
end
