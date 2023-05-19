defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  # initialize state with an tuple, with a list, and the next_id counter
  def start(_opts \\ []), do: Agent.start(fn -> {[], 1} end)

  def list_registrations(pid), do: Agent.get(pid, fn {list, _} -> list end)

  def register(pid, register_to) do
    Agent.update(pid, fn {list, counter} ->
      new_plot = %Plot{plot_id: counter, registered_to: register_to}
      {[new_plot | list], counter + 1}
    end)

    Agent.get(pid, fn {[first_plot | _], _} -> first_plot end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn {list, counter} ->
      {Enum.filter(list, fn %{plot_id: id} -> plot_id != id end), counter}
    end)
  end

  def get_registration(pid, plot_id) do
    plot =
      Agent.get(pid, fn {list, _} ->
        Enum.find(list, {:not_found, "plot is unregistered"}, fn %{plot_id: id} ->
          plot_id == id
        end)
      end)

    plot
  end
end
