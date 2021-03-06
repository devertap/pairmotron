defmodule Pairmotron.PairViewTest do
  use Pairmotron.ConnCase, async: true
  import Pairmotron.TestHelper, only: [log_in: 2]
  alias Pairmotron.PairView

  describe ".current_user_in_pair" do
    test "is false when the logged in user is not in the pair" do
      logged_in_user = insert(:user)
      other_user = insert(:user)
      group = insert(:group, %{owner: logged_in_user})
      pair = Pairmotron.TestHelper.create_pair([other_user], group) |> Pairmotron.Repo.preload([:users])
      conn = build_conn() |> log_in(logged_in_user)
      refute PairView.current_user_in_pair(conn, pair)
    end

    test "is true when the logged in user is in the pair" do
      user = insert(:user)
      group = insert(:group, %{owner: user})
      pair = Pairmotron.TestHelper.create_pair([user], group) |> Pairmotron.Repo.preload([:users])
      conn = build_conn() |> log_in(user)
      assert PairView.current_user_in_pair(conn, pair)
    end

    test "is false when no user is logged in" do
      user = insert(:user)
      group = insert(:group, %{owner: user})
      pair = Pairmotron.TestHelper.create_pair([user], group)
      conn = build_conn()
      refute PairView.current_user_in_pair(conn, pair)
    end
  end
end
