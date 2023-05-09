defmodule LibraryFees do
  def datetime_from_string(string), do: string |> NaiveDateTime.from_iso8601!()

  @spec before_noon?(NaiveDateTime.t()) :: boolean()
  def before_noon?(%{hour: hour}), do: hour < 12

  @spec return_date(NaiveDateTime.t()) :: Date.t()
  def return_date(checkout_datetime) do
    days_to_add = if before_noon?(checkout_datetime), do: 28, else: 29
    checkout_datetime |> Date.add(days_to_add)
  end

  @spec days_late(planned_return_date :: Date.t(), actual_return_date :: NaiveDateTime.t()) ::
          integer()
  def days_late(planned_date, actual_date) do
    days = Date.diff(actual_date, planned_date)
    if days < 0, do: 0, else: days
  end

  @spec monday?(NaiveDateTime.t()) :: boolean()
  def monday?(datetime) do
    day_of_week = datetime |> NaiveDateTime.to_date() |> Date.day_of_week()

    if day_of_week == 1, do: true, else: false
  end

  @spec calculate_late_fee(
          checkout :: String.t(),
          return :: String.t(),
          rate :: integer()
        ) :: integer()
  def calculate_late_fee(checkout, return, rate) do
    planned_return_date = checkout |> datetime_from_string() |> return_date()
    days_late = planned_return_date |> days_late(datetime_from_string(return))

    fee = days_late * rate
    if monday?(return |> datetime_from_string()), do: (fee * 0.5) |> trunc(), else: fee
  end
end
