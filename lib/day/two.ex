defmodule Day.Two do
  def part_1 do
    File.stream!("./input_two.txt")
    |> Stream.map(&String.trim/1)
    |> Stream.map(fn input ->
       case input do
         "forward "<> input -> {:forward, String.to_integer(input)}
         "down " <> input -> {:down, String.to_integer(input)}
         "up " <> input -> {:up, String.to_integer(input)}
       end
    end)
    |> Enum.reduce({0, 0}, fn
      {:forward, n}, {horizontal, depth} -> {horizontal + n, depth}
      {:down, n}, {horizontal, depth} -> {horizontal, depth + n}
      {:up, n}, {horizontal, depth} -> {horizontal, depth - n}
    end)
    |> Tuple.product()
  end

  def part_2 do
    {horizontal, depth, _} = File.stream!("./input_two.txt")
    |> Stream.map(&String.trim/1)
    |> Stream.map(fn input ->
       case input do
        "forward "<> input -> {:forward, String.to_integer(input)}
        "down " <> input -> {:down, String.to_integer(input)}
        "up " <> input -> {:up, String.to_integer(input)}
      end
    end)
    |> Enum.reduce({0,0,0}, fn
      {:down, n}, {horizontal, depth, aim} -> {horizontal, depth, aim + n}
      {:up, n}, {horizontal, depth, aim} -> {horizontal, depth, aim - n}
      {:forward, n}, {horizontal, depth, aim} -> {horizontal + n, depth + aim * n, aim}
    end)

    horizontal * depth
  end
end

IO.puts Day.Two.part_1
IO.puts Day.Two.part_2
