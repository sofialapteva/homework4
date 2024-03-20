defmodule Homework4 do
  @moduledoc ~S"""

  ## Examples

      iex> {:ok, pid} = Homework4.start_link()
      iex> Homework4.get(pid)
      %{state: :stopped}
      iex> Homework4.transition(pid, :run_engine)
      %{state: :idle}
      iex> Homework4.transition(pid, :start_moving)
      %{state: :moving}
      iex> Homework4.transition(pid, :stowaway_jumps_on_the_bandwagon)
      :ok
      iex> Process.sleep(100)
      iex> Homework4.get(pid)
      %{state: :hijacked}

  """

  use GenServer
  # Client
  def hint do
    IO.puts("Possible transitions:
   :stopped -->:run_engine --> :idle
   :idle -->:stop_engine --> :stopped
   :idle -->:start_moving --> :movingmoving
   :moving -->:stop_moving --> :idle
   :idle -->:open_doors --> :boarding
   :moving -->:stowaway_jumps_on_the_bandwagon --> :hijacked
   :hijacked -->:ticket_inspector_evicts_a_stowaway --> :idle
   :boarding -->:close_doors --> :idle
   :moving -->:make_turn --> :moving")
  end

  def start_link(initial_state \\ %{state: :stopped}) do
    GenServer.start_link(__MODULE__, initial_state)
  end

  def get(pid), do: GenServer.call(pid, :get_state)

  def transition(pid, :run_engine), do: GenServer.call(pid, :run_engine)

  def transition(pid, :stop_engine), do: GenServer.call(pid, :stop_engine)

  def transition(pid, :start_moving), do: GenServer.call(pid, :start_moving)

  def transition(pid, :stop_moving), do: GenServer.call(pid, :stop_moving)

  def transition(pid, :open_doors), do: GenServer.call(pid, :open_doors)

  def transition(pid, :close_doors), do: GenServer.call(pid, :close_doors)

  def transition(pid, :make_turn), do: GenServer.call(pid, :make_turn)

  def transition(pid, :stowaway_jumps_on_the_bandwagon),
    do: GenServer.cast(pid, :stowaway_jumps_on_the_bandwagon)

  def transition(pid, :ticket_inspector_evicts_a_stowaway),
    do: GenServer.cast(pid, :ticket_inspector_evicts_a_stowaway)

  def transition(pid, event), do: GenServer.call(pid, event)

  # Server (callbacks)

  @impl true
  def init(initial_state) do
    {:ok, initial_state}
  end

  @impl true
  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_call(:run_engine, _from, state = %{state: :stopped}) do
    state = Map.replace(state, :state, :idle)
    {:reply, state, state}
  end

  @impl true
  def handle_call(:stop_engine, _from, state = %{state: :idle}) do
    state = Map.replace(state, :state, :stopped)
    {:reply, state, state}
  end

  @impl true
  def handle_call(:start_moving, _from, state = %{state: :idle}) do
    state = Map.replace(state, :state, :moving)
    {:reply, state, state}
  end

  @impl true
  def handle_call(:stop_moving, _from, state = %{state: :moving}) do
    state = Map.replace(state, :state, :idle)
    {:reply, state, state}
  end

  @impl true
  def handle_call(:open_doors, _from, state = %{state: :idle}) do
    state = Map.replace(state, :state, :boarding)
    {:reply, state, state}
  end

  @impl true
  def handle_call(:close_doors, _from, state = %{state: :boarding}) do
    state = Map.replace(state, :state, :idle)
    {:reply, state, state}
  end

  @impl true
  def handle_call(:make_turn, _from, state = %{state: :moving}) do
    state = Map.replace(state, :state, :moving)
    {:reply, state, state}
  end

  @impl true
  def handle_call(event, _from, state) do
    IO.warn(
      "This is not a valid transition: there's no implementation of the transition from state :#{state.state} with event :#{event}"
    )

    {:reply, state, state}
  end

  @impl true
  def handle_cast(:stowaway_jumps_on_the_bandwagon, state = %{state: :moving}) do
    {:noreply, Map.replace(state, :state, :hijacked)}
  end

  @impl true
  def handle_cast(:ticket_inspector_evicts_a_stowaway, state = %{state: :hijacked}) do
    {:noreply, Map.replace(state, :state, :idle)}
  end

  @impl true
  def handle_cast(event, state) do
    IO.warn(
      "This is not a valid transition: there's no implementation of the transition from state :#{state.state} with event :#{event}. \nPress Enter to continue."
    )

    {:noreply, state}
  end
end
