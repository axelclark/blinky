defmodule Blinky do
  
  alias Nerves.Leds
  require Logger

  def start(_type, _args) do
    led_list = Application.get_env(:blinky, :led_list)
    Logger.debug "list of leds to blink is #{inspect led_list}"
    spawn fn -> blink_list_forever(led_list) end
    {:ok, self}
  end

  defp blink_list_forever(led_list) do
    Enum.each(led_list, &blink(&1))
    blink_list_forever(led_list)
  end

  defp blink(led_key) do
    Leds.set [{led_key, :slowblink}]
    :timer.sleep 2500
    Leds.set [{led_key, :heartbeat}]
  end
end
