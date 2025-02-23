defmodule VenieriWeb.BioLive do
  use VenieriWeb, :live_view
  require Logger
  alias Venieri.Repo
  alias Venieri.Archives.Projects
  alias Venieri.Archives.Events
  alias Venieri.Archives.References

  import VenieriWeb.Components.Navbar

  @impl true
  def render(assigns) do
    ~H"""
     <.navbar socket={@socket}/>
      <div class="mb-5 mt-10">
      <h1 class="text-2xl/7 font-bold text-gray-700 sm:truncate sm:text-3xl sm:tracking-tight">BIO</h1>
      </div>

      <div class="card card-side ml-0">
      <div class="card-body  px-0">
      <p>Born in Athens, Greece</p>
      <p>Lives and works in New York and Athens</p>

      <div class="min-w-0 flex-1 mb-1 mt-3">
      <h2 class="text-xl/7 font-bold text-gray-900 sm:truncate sm:text-2xl sm:tracking-tight">EDUCATION</h2>
      </div>

      <div class="min-w-0 flex-1 mb-3 mt-2">
      <p>Studied at the Ecole Nationale, Superieure des
      Beaux Arts</p>
      </div>
      </div>




        <figure>
          <img
            src="https://www.venieri.com/media/__sized__/art/lydia-venieri-lydia-venieri-thumbnail-650x433.png"
            alt="Lydia venieri, 1988" />
        </figure>

      </div>



      <div class="min-w-0 flex-1 mb-1 mt-3">
      <h2 class="text-xl/7 font-bold text-gray-900 sm:truncate sm:text-2xl sm:tracking-tight">Solo Shows</h2>
      </div>

      <ul role="list" class="divide-y divide-gray-100">
            <%= for {year, shows} <- @solo_shows  do %>
            <li class="gap-x-6">
            <b class="font-sans"><%= year %> -</b>
              <%= for show <- shows do %>
                <a class="text-sm" href={"/events/#{show.id}"}><%= show.title %></a>, <span class="font-light text-xs"><%= show.venue %></span><br />
              <% end %>
              </li>
            <% end %>
      </ul>

      <div class="min-w-0 flex-1 mb-1 mt-3">
      <h2 class="text-xl/7 font-bold text-gray-900 sm:truncate sm:text-2xl sm:tracking-tight">Group Shows</h2>
      </div>

      <ul role="list" class="divide-y divide-gray-100">
            <%= for {year, shows} <- @group_shows  do %>
            <li class="gap-x-6">
            <b class="font-sans"><%= year %> -</b>
              <%= for show <- shows do %>
                <a class="text-sm" href={"/events/#{show.id}"}><%= show.title %></a>, <span class="font-light text-xs"><%= show.venue %></span><br />
              <% end %>
              </li>
            <% end %>
      </ul>

      <div class="min-w-0 flex-1 mb-1 mt-3">
        <h2 class="text-xl/7 font-bold text-gray-900 sm:truncate sm:text-2xl sm:tracking-tight">Animations and Videos</h2>
      </div>
      <ul role="list" class="divide-y divide-gray-100">
        <li class="gap-x-6">Lenaki: Dyo foties kai dyo katares, director Dimitris Indares, 2024</li>
        <li class="gap-x-6">La Vestale, 2023</li>
        <li class="gap-x-6">Byronic Codex - a Documentary, 2022</li>
        <li class="gap-x-6">The Siege of Corinth, 2021</li>
        <li class="gap-x-6">The TROPARY OF KASSIANI, 2020</li>
        <li class="gap-x-6">Metamorphoses, 2019</li>
        <li class="gap-x-6">The Dolphin Conspiracy, 2018</li>
        <li class="gap-x-6">Pasiphaë, 2018</li>
        <li class="gap-x-6">The Kiss, 2015</li>
        <li class="gap-x-6">Tomorrow, 2009</li>
        <li class="gap-x-6">Moonlight, 2007</li>
        <li class="gap-x-6">Forever After, 2004</li>
        <li class="gap-x-6">Sleeping Beauty Conscience, 2002</li>
        <li class="gap-x-6">Lullaby, 2000</li>
        <li class="gap-x-6">Epilepsy, 2005</li>
        <li class="gap-x-6">Martha, 1996</li>
        <li class="gap-x-6">Egg, 1995</li>
      </ul>

      <div class="min-w-0 flex-1 mb-1 mt-3">
      <h2 class="text-xl/7 font-bold text-gray-900 sm:truncate sm:text-2xl sm:tracking-tight">Books and Illustrations</h2>
      </div>

      <ul role="list" class="divide-y divide-gray-100">
        <li class="gap-x-6">The First Secret: a magic recipe
        by Elina Stamatatou, illustrated by Lydia Venieri, 2014</li>
        <li class="gap-x-6">Moonlight, Lydia Venieri, 2006</li>
        <li class="gap-x-6">Beyond Being, Lydia Venieri, 2000</li>
        <li class="gap-x-6">Healthy Perversions by Tzimy Panousi, illustrated by Lydia Venieri, 1995</li>
      </ul>



      <div class="min-w-0 flex-1 mb-1 mt-3">
      <h2 class="text-xl/7 font-bold text-gray-900 sm:truncate sm:text-2xl sm:tracking-tight">Internet Art</h2>
      </div>

      <ul role="list" class="divide-y divide-gray-100">
      <li class="gap-x-6">Katerina, 1997</li>
      <li class="gap-x-6">Apology, 1996</li>
      <li class="gap-x-6">Isis, 1995</li>
      <li class="gap-x-6">Her Story, 1995</li>
      <li class="gap-x-6">Temple, 1995</li>
      <li class="gap-x-6">Tarot, 1995</li>
      <li class="gap-x-6">Fin, 1994</li>
      </ul>


      <div class="min-w-0 flex-1 mb-1 mt-3">
      <h2 class="text-xl/7 font-bold text-gray-900 sm:truncate sm:text-2xl sm:tracking-tight">Theatre</h2>
      </div>
      <ul role="list" class="divide-y divide-gray-100">
      <li class="gap-x-6">GASPARE SPONTINI'S LA VESTALE,  2023</li>
      <li class="gap-x-6">LOVE - WALTZ WITH EROS - ΒΑΛΣ ΜΕ ΤΟΝ ΈΡΩΤΑ,  2023</li>
      <li class="gap-x-6">Scenery and costume for Mr. Love, 2015</li>
      <li class="gap-x-6">Sarah & Lorraine by Marc Israel-Le Pelletier, Storefront Theatre, 2008</li>
      <li class="gap-x-6">Sarah & Lorraine by Marc Israel-Le Pelletier, Sanford Meisner Theatre, 2007</li>
      <li class="gap-x-6">Lady form Ancona, Anatolia of my Soul: 75 years since the Asian Minor Catastrophy, Lykabetus Theatre, 1997</li>
      <li class="gap-x-6">The Lady from Ancona, Theatre of Komotini, 1996</li>
      <li class="gap-x-6">Hellenic Orchestra's tour of USSR, 1996</li>
      <li class="gap-x-6">The Five Seasons, Dance theater Octana, 1995</li>
      <li class="gap-x-6">Daphnis & Cloe, Octana Theatrical Group, 1994</li>
      <li class="gap-x-6">Inventaires" de Philippe Minyana, 1993</li>
      </ul>


      <div class="min-w-0 flex-1 mb-1 mt-3">
      <h2 class="text-xl/7 font-bold text-gray-900 sm:truncate sm:text-2xl sm:tracking-tight">Awards and Commissions</h2>
      </div>
      <ul role="list" class="divide-y divide-gray-100">
      <li class="gap-x-6">Medal for Sculpture, Academie Francaise de Paris, 2004</li>
      <li class="gap-x-6">Tower of Symbols, Open Air Sculpture, Central Athens, 2004</li>
      <li class="gap-x-6">Wall of Symbols, Sculpture, Atelier Mallet Stevens, Paris</li>
      <li class="gap-x-6">Lydia on Broadway.com, CD-ROM sponsored by Art Magazine and Hewlett Packard</li>
      <li class="gap-x-6">“Infinity”, Collaboration with artist Takis on the sculpture.</li>
      <li class="gap-x-6">Commande en plein air d'une serie de sculputre Eros et Psyche, Fondation Alexandre Iolas, Athenes</li>
      <li class="gap-x-6">Commande d'une serie de sculptures pour l'Incitation a la Creation, Abbaye de Montmajour, Arles</li>
      <li class="gap-x-6">Carte Blanche, a l'occation de l'anniversaire de 10 ans du Centre George Pompidou, Galeries Contemporaines, Paris</li>
      </ul>



      <div class="min-w-0 flex-1 mb-1 mt-3">
      <h2 class="text-xl/7 font-bold text-gray-900 sm:truncate sm:text-2xl sm:tracking-tight">Exhibition Catalogs</h2>
      </div>

      <ul role="list" class="divide-y divide-gray-100">
      <li class="gap-x-6">The Dolphin Conspiracy, Nadia Argyropoulou, 2010</li>
      <li class="gap-x-6">No Evil, Beth Wilson, 2008</li>
      <li class="gap-x-6">Oh You beautiful Doll, Douglas F. Maxwell, 2006</li>
      <li class="gap-x-6">For Ever After, Niko Daskalothanassi, 2005</li>
      <li class="gap-x-6">Olympic 2004, Nelly Kyriazi, 2004</li>
      <li class="gap-x-6">Alive in new York, Nadia Argyropoulou, 2003</li>
      <li class="gap-x-6">Hibernation, Marek Bartelik, 2002</li>
      <li class="gap-x-6">Propos d’Europe, Jean Guyot and Pascale le Thorel, 2002</li>
      <li class="gap-x-6">Pandora’s Box, Women Beyond Borders, Sania Papa, 2000</li>
      <li class="gap-x-6">Truthful and Authentic Communication, Sania Papa, 2000</li>
      <li class="gap-x-6">Beyond Being, Lydia Venieri, 2000</li>
      <li class="gap-x-6">Approaching Hellinism, Nelly Kyriazi, 1999</li>
      <li class="gap-x-6">Lydia’s Cool Memories, Sania Papa, 1997</li>
      <li class="gap-x-6">Who is Nostalgic, Nikos Dalaretos, 1999</li>
      <li class="gap-x-6">Manifesta, 1996</li>
      <li class="gap-x-6">Telluric Manifesto, Sania Papa, 1994</li>
      <li class="gap-x-6">Anima Mundis, Takis, 1993</li>
      <li class="gap-x-6">Ermata, Wanderings of the Sacred, Sania Papa, 1992</li>
      <li class="gap-x-6">Spira, Sania Papa, 1992</li>
      <li class="gap-x-6">Metamorphose of the Modern, Anna Kafetzi, 1991</li>
      <li class="gap-x-6">Chimes of Time, Jacques Lacarriere, 1990</li>
      <li class="gap-x-6">Humor ad Revolution, Cannes & Barselona, 1989</li>
      <li class="gap-x-6">Spirit and Body, Dora Rogan, 1989</li>
      <li class="gap-x-6">The Gods Revist, Pierrre Giquel, 1988</li>
      <li class="gap-x-6">The Figures of Lydia, Demosthenes Davetas, Edition Agras, 1988</li>
      <li class="gap-x-6">Lydia Venieri -FIAC 88, Nicole Kinge, 1988</li>
      <li class="gap-x-6">Lydia Venieri, Gerard Barriere, 1988</li>
      <li class="gap-x-6">Carte Blanche, Centre George Pompidou, 1987</li>
      </ul>

      <div class="min-w-0 flex-1 mb-1 mt-3">
      <h2 class="text-xl/7 font-bold text-gray-900 sm:truncate sm:text-2xl sm:tracking-tight">Articles & References</h2>
      </div>

      <ul role="list" class="divide-y divide-gray-100">
        <%= for info <- @references  do %>
            <li class="gap-x-6">
            <span class="italic">
            <%= info.title %>
            <%= if info.authors  do %>
      , <%= info.authors %>
        <% end %>
            </span> <%= info.publication %> <%= info.publication_date %>
              </li>
            <% end %>
      </ul>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    # socket = assign(socket, page: 1)

    # # on initial load it'll return false,
    # # then true on the next.
    # if connected?(socket) do
    #   get_events(socket)
    # else
    #   socket
    # end
    solo_shows = Events.events_by_tag("Solo Show")
    group_shows = Events.events_by_tag("Group Show")

    references =
      References.list()
      |> Enum.sort_by(& &1.publication_date, :desc)

    {:ok,
     socket
     |> assign(solo_shows: solo_shows)
     |> assign(group_shows: group_shows)
     |> assign(references: references)}

    # {:ok,
    #  socket
    #  |> assign(page: 0), temporary_assigns: [events: []]}
  end

  @impl true
  def handle_event(_, _, socket) do
    {:noreply, socket}
  end
end
