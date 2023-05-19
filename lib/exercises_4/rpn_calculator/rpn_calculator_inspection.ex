defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    pid = spawn_link(fn -> input |> calculator.() end)
    %{input: input, pid: pid}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.merge(results, %{input => :ok})
      {:EXIT, ^pid, _reason} -> Map.merge(results, %{input => :error})
    after
      100 -> Map.merge(results, %{input => :timeout})
    end
  end

  def reliability_check(calculator, inputs) do
    trap_exit_flag = Process.flag(:trap_exit, true)

    reliability_checks =
      inputs
      |> Enum.map(fn input -> start_reliability_check(calculator, input) end)
      |> Enum.map(fn input -> await_reliability_check_result(input, %{}) end)

    Process.flag(:trap_exit, trap_exit_flag)
    reliability_checks |> Enum.reduce(%{}, fn input, acc -> input |> Map.merge(acc) end)
  end

  def correctness_check(calculator, inputs) do
    inputs
    |> Enum.map(fn input -> Task.async(fn -> input |> calculator.() end) end)
    |> Enum.map(fn task -> task |> Task.await(100) end)
  end
end
