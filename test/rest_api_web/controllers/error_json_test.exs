defmodule RestApiWeb.ErrorJSONTest do
  use RestApiWeb.ConnCase, async: true

  test "renders 404" do
    assert RestApiWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{message: "Not Found"}}
  end

  test "renders 500" do
    assert RestApiWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{message: "Internal Server Error"}}
  end
end
