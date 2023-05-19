defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    @error_message "stack underflow occurred"
    defexception message: @error_message

    @impl true
    def exception(context) do
      case context do
        [] -> %StackUnderflowError{}
        _ -> %StackUnderflowError{message: @error_message <> ", context: " <> context}
      end
    end
  end

  def divide(stack) when length(stack) <= 1, do: raise(StackUnderflowError, "when dividing")
  def divide(stack) when hd(stack) == 0, do: raise(DivisionByZeroError)
  def divide([d, n]), do: n / d
end
