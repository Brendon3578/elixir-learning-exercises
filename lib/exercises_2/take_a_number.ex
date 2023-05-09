defmodule TakeANumber do
  @spec start() :: pid()
  def start do
    spawn(fn -> loop(0) end)
  end

  def loop, do: nil

  def loop(state) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, state)
        loop(state)

      {:take_a_number, sender_pid} ->
        send(sender_pid, state + 1)
        loop(state + 1)

      :stop ->
        loop()

      _ ->
        loop(state)
    end
  end
end
