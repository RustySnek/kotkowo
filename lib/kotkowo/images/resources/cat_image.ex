defmodule Kotkowo.Images.CatImage do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshGraphql.Resource],
    authorizers: [Ash.Policy.Authorizer]

  policies do
    bypass actor_present() do
      authorize_if always()
    end

    policy action_type(:read) do
      authorize_if always()
    end

    policy always() do
      authorize_if always()
    end
  end

  graphql do
    type :cat_image
  end

  postgres do
    table "cat_images"
    repo Kotkowo.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  calculations do
    calculate :url, :string, {Calculations.S3Upload, [segments: [:cat_id, :id], bucket: "images"]}

    calculate :upload_url,
              :string,
              {Calculations.S3Upload, [segments: [:cat_id, :id], bucket: "images", write: true]}
  end
  
  attributes do
    uuid_primary_key :id

    attribute :filename, :string

    relationships do
      belongs_to :cat, Kotkowo.Adoption.Cat do
        api Kotkowo.Adoption
        allow_nil? false
      end
    end
  end
end
