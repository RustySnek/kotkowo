defmodule Kotkowo.Images.CatImage do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshGraphql.Resource],
    authorizers: [Ash.Policy.Authorizer]

  policies do
    policy always() do
      authorize_if always()
    end
  end

  postgres do
    table "cat_images"
    repo Kotkowo.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  attributes do
    uuid_primary_key :id

    relationships do
      belongs_to :cat, Kotkowo.Adoption.Cat do
        api Kotkowo.Adoption
        primary_key? true
        allow_nil? false
      end

      belongs_to :image, Kotkowo.Images.Image do
        api Kotkowo.Images
        primary_key? true
        allow_nil? false
      end
    end
  end
end
