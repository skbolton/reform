defmodule Reform.Cursor do
  @type t :: {list(), map()}
  def new() do
    {[], %{}}
  end

  def new(map) when is_map(map) do
    {[], map}
  end

  def focus({_thread, focus}), do: focus

  def replace({thread, _focus}, value) do
    {thread, value}
  end

  def up({[backtrack | rest], _focus}), do: {:ok, {rest, backtrack}}
  def up({[], _focus}), do: {:error, :cannot_make_move}

  def top(cursor) do
    case up(cursor) do
      {:ok, new_cursor} ->
        top(new_cursor)

      {:error, :cannot_make_move} ->
        cursor
    end
  end
end
