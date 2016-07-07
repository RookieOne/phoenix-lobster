defmodule PhoenixLobstersTest.Actions.SiginUserTest do
  use ExUnit.Case
  alias PhoenixLobsters.Actions.SigninUser
  import PhoenixLobsters.TestHelper

  @tag :actions
  @tag :user
  @tag :authentication
  test "Signin user should return user" do
    email = gen_fake_email( "tony" )
    {:ok, user} = add_user(email: email, password: "iamironman")

    {:ok, signedin_user} = SigninUser.execute(email, "iamironman")

    assert signedin_user.id == user.id
    assert signedin_user.email == email
  end

  @tag :actions
  @tag :user
  @tag :authentication
  test "Signin user should return error if password is wrong" do
    email = gen_fake_email( "tony" )
    {:ok, _} = add_user(email: email, password: "iamironman")

    {:error, message} = SigninUser.execute( email, "wrongpassword")

    assert message == "Email and/or password invalid"
  end

end
