defmodule Newsletter do
  @type email :: String.t()
  @type email_list :: list(email)

  @spec read_emails(String.t()) :: email_list() | []
  def read_emails(path) do
    path |> File.read!() |> String.split()
  end

  @spec open_log(String.t()) :: pid()
  def open_log(path), do: File.open!(path, [:write])

  @spec log_sent_email(pid(), String.t()) :: :ok
  def log_sent_email(pid, email), do: IO.puts(pid, email)

  @spec close_log(pid()) :: :ok
  def close_log(pid), do: File.close(pid)

  @spec send_newsletter(String.t(), String.t(), fun(email())) :: :ok
  def send_newsletter(emails_path, log_path, send_fun) do
    pid_log = open_log(log_path)

    read_emails(emails_path)
    |> Enum.each(fn email ->
      if send_fun.(email) == :ok, do: log_sent_email(pid_log, email)
    end)

    close_log(pid_log)
  end
end
