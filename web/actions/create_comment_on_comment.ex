defmodule PhoenixLobsters.Actions.CreateCommentOnComment do
  alias PhoenixLobsters.Comment
  alias PhoenixLobsters.Repo

  @moduledoc """
  The CreateCommentOnComment action creates a comment on a comment.

  It handles compiling the markdown, marking submission time, and so forth.

  Usage:
    execute( author_id, uncompiled_markdown, parent_story, parent_comment )
  """

  def execute( author_id, uncompiled_markdown, parent_story_id, parent_comment_id ) do
    changeset = Comment.changeset( %Comment{}, %{ user_id: author_id,
                                                  uncompiled_markdown: uncompiled_markdown,
                                                  compiled_html: Earmark.to_html( uncompiled_markdown ),
                                                  story_id: parent_story_id,
                                                  comment_id: parent_comment_id,
                                                  slug: "TODO" <> :base64.encode( :crypto.strong_rand_bytes(8))
      })
    case Repo.insert(changeset)  do
      {:ok, comment} -> {:ok, comment}
      {:error, changeset} -> {:error, changeset.errors}
    end
  end
end