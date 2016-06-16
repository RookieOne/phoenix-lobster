defmodule PhoenixLobsters.User do
  use PhoenixLobsters.Web, :model

    @moduledoc """
      User's in Lobster are allowed to post stories and create comments based on permissions
      This record is responsible for keeping track of a user's profile information
      and is responsible for managing user registration and authentication
    """
    schema "users" do
      field :email, :string
      field :hashed_password, :string
      field :display_name, :string
      field :description_markdown, :string
      field :description_html, :string

      has_many :stories, PhoenixLobsters.Story

      timestamps
    end

    @required_fields ~w( display_name email hashed_password )
    @optional_fields ~w( description_markdown description_html )

    def changeset( model, params \\ :empty ) do
      model
      |> cast( params, @required_fields, @optional_fields )
      # email must be unique
      |> unique_constraint(:email)
      # the validation for display name was pulled from Lobster's site
      |> validate_format(:display_name, ~r/\A[A-Za-z0-9][A-Za-z0-9_-]{0,24}\Z/)
    end

end
