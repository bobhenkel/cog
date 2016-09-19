defmodule Cog.Chat.Slack.Templates.Embedded.UserGroupListVerboseTest do
  use Cog.TemplateCase

    test "user-group-list-verbose template with multiple inputs" do
    data = %{"results" => [%{"name" => "foo",
                             "id" => "123",
                             "roles" => [%{"name" => "heroku-admin"},
                                         %{"name" => "aws-admin"}],
                             "members" => [%{"username" => "larry"},
                                           %{"username" => "moe"},
                                           %{"username" => "curly"}]},
                           %{"name" => "bar",
                             "id" => "456",
                             "roles" => [%{"name" => "bar-admin"}],
                             "members" => [%{"username" => "sterling"},
                                           %{"username" => "lana"},
                                           %{"username" => "pam"}]},
                          %{"name" => "baz",
                             "id" => "789",
                             "roles" => [%{"name" => "baz-admin"}],
                             "members" => [%{"username" => "tina"},
                                           %{"username" => "gene"},
                                           %{"username" => "louise"}]}]}

    expected = """
    ```+------+-----+-------------------------+---------------------+
    | Name | ID  | Roles                   | Members             |
    +------+-----+-------------------------+---------------------+
    | foo  | 123 | heroku-admin, aws-admin | larry, moe, curly   |
    | bar  | 456 | bar-admin               | sterling, lana, pam |
    | baz  | 789 | baz-admin               | tina, gene, louise  |
    +------+-----+-------------------------+---------------------+
    ```
    """ |> String.strip

    assert_rendered_template(:slack, :embedded, "user-group-list-verbose", data, expected)
  end

end
