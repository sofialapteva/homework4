# Homework4

```mermaid
flowchart TD
    A[stopped] -->|run_engine| B[idle]
    B -->|stop_engine| A
    B -->|start_moving| C[moving]
    C -->|stop_moving| B
    B -->|open_doors| D[boarding]
    D -->|close_doors| B
    C -->|make_turn| C
    C -->|stowaway_jumps_on_the_bandwagon| E[hijacked]
    E -->|ticket_inspector_evicts_a_stowaway| B
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `homework4` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:homework4, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/homework4](https://hexdocs.pm/homework4).
