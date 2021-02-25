defmodule Reform do
  alias Reform.Cursor

  defstruct [:form, :draft]

  @type t :: %__MODULE__{
    form: Cursor.t(),
    draft: Cursor.t()
  }

  def new(form) when is_map(form) do
    %__MODULE__{
      form: Cursor.new(form),
      draft: Cursor.new()
    }
  end

  def take(%__MODULE__{form: form, draft: draft}, keys) when is_list(keys) do
    draft_focus = Cursor.focus(draft)
    form_focus = Cursor.focus(form)

    taken =
      keys
      |> Enum.map(fn
        {key, mapping} ->
          {mapping, Map.get(form_focus, key)}

        key ->
          {key, Map.get(form_focus, key)}
      end)
      |> Enum.into(%{})

    new_draft_focus = Map.merge(draft_focus, taken)
    %__MODULE__{draft: Cursor.replace(draft, new_draft_focus), form: form}
  end

  def run(%__MODULE__{draft: draft}) do
    draft
    |> Cursor.top()
    |> Cursor.focus()
  end
end
