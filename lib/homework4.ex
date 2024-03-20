defmodule Homework4 do
  @moduledoc ~S"""

  ## Examples

      iex> Homework4.start_link()
      iex> Homework4.get()
      :stopped
      iex> Homework4.transition(:run_engine)
      :ok
      iex> Homework4.get()
      :idle
      iex> Homework4.transition(:start_moving)
      :ok
      iex> Homework4.get()
      :moving

  """

  use GenServer
  # Client
  def hint do
    IO.puts("""
    Possible transitions:
    :stopped -->|run_engine| :idle
    :idle -->|stop_engine| :stopped
    :idle -->|start_moving| :moving
    :moving -->|stop_moving| :idle
    :idle -->|open_doors| :boarding
    :boarding -->|close_doors| :idle
    :moving -->|make_turn| :moving
    """)
  end

  def start_link(initial_state \\ :stopped) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def get(pid \\ __MODULE__), do: GenServer.call(pid, :get_state)

  def transition(state, pid \\ __MODULE__), do: GenServer.cast(pid, state)

  # Server (callbacks)

  @impl true
  def init(initial_state) do
    {:ok, initial_state}
  end

  @impl true
  def handle_call(:get_state, _from, state), do: {:reply, state, state}

  @impl true
  def handle_cast(:run_engine, :stopped), do: {:noreply, :idle}

  @impl true
  def handle_cast(:stop_engine, :idle), do: {:noreply, :stopped}

  @impl true
  def handle_cast(:start_moving, :idle), do: {:noreply, :moving}

  @impl true
  def handle_cast(:stop_moving, :moving), do: {:noreply, :idle}

  @impl true
  def handle_cast(:open_doors, :idle), do: {:noreply, :boarding}

  @impl true
  def handle_cast(:close_doors, :boarding), do: {:noreply, :idle}

  @impl true
  def handle_cast(:make_turn, :moving), do: {:noreply, :moving}

  @impl true
  def handle_cast(event, state) do
    IO.warn("""
    This is not a valid transition.
    There's no implementation of the transition from state :#{state} with event :#{event}.
    """)

    {:noreply, state}
  end
end
