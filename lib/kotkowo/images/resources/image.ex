defmodule Kotkowo.Images.Image do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshGraphql.Resource],
    authorizers: [Ash.Policy.Authorizer]

  policies do
    policy always() do
      authorize_if always()
    end
  end

  graphql do
    type :image

    queries do
      get(:get_image, :read)
    end
  end

  attributes do
    uuid_primary_key :id
    # used to store preprocessed image until it gets
    attribute :temporary_base64, :string
    attribute :url, :string
    attribute :sizes, {:array, :string}
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  postgres do
    table "images"
    repo Kotkowo.Repo
  end
end
