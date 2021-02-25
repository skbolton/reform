defmodule ReformTest do
  use ExUnit.Case

  describe "new/1" do
    test "returns a reform" do
      assert %Reform{} = Reform.new(%{})
    end
  end

  describe "take/2" do
    test "reads keys from form onto draft" do
      focus = Reform.new(%{name: "Zohan", age: 30, occupation: "developer"})
               |> Reform.take([:name, :occupation])
               |> Reform.run()

      assert %{name: "Zohan", occupation: "developer"} = focus
      refute Map.has_key?(focus, :age)
    end

    test "mapping key can also be passed with key to take" do
      focus = Reform.new(%{name: "Zohan", age: 30, occupation: "developer"})
               |> Reform.take([:name, {:occupation, :job}])
               |> Reform.run()

      assert %{name: "Zohan", job: "developer"} = focus
      refute Map.has_key?(focus, :age)
    end
  end
end
