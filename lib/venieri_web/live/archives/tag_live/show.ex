defmodule VenieriWeb.Archives.TagLive.Show do
  use VenieriWeb, :live_view

  alias Venieri.Archives.Tags

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:tag, Tags.get!(id))}
  end

  defp page_title(:show), do: "Show Tag"
  defp page_title(:edit), do: "Edit Tag"
end
