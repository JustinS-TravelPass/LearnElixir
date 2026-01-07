defmodule Demo do
  defmacro work(time) do
    quoted_code =
      quote bind_quoted: [time: time] do
        # Even though we are waiting a second before inpecting time, the output will be the same because quote captures the initial value.
        time |> IO.inspect()
        :timer.sleep(1000)
        time |> IO.inspect()

        # Using unquoted however does not return the captured value but the actual time value.
        unquote(time) |> IO.inspect()
        :timer.sleep(1000)
        unquote(time) |> IO.inspect()
      end

    # quoted_code |> Macro.to_string() |> IO.inspect()

    quoted_code
  end
end

defmodule Playground do
  require Demo

  def test! do
    another_val = "value from test!"
    :os.system_time() |> Demo.work()
  end
end

Playground.test!()
