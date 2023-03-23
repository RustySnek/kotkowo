defmodule Kotkowo.Adoption.Cat do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [
      AshGraphql.Resource
    ],
    authorizers: [
      Ash.Policy.Authorizer
    ]

  policies do
    policy action_type(:read) do
      authorize_if always()
    end

    policy always() do
      authorize_if actor_present()
    end
  end

  graphql do
    type :cat

    queries do
      get(:get_cat, :read)
      list(:list_cat, :list)
    end

    mutations do
      create :create_cat, :create
      update :update_cat, :update
      destroy :destroy_cat, :destroy
    end
  end

  postgres do
    table "cats"
    repo Kotkowo.Repo
  end

  actions do
    defaults [:create, :read, :update, :destroy]

    read :list do
      pagination do
        offset? true
        countable true
        max_page_size 50
      end
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string do
      allow_nil? false
    end

    attribute :sex, :atom do
      constraints one_of: [:male, :female]
    end

    attribute :age, :atom do
      constraints one_of: [:junior, :senior]
    end

    attribute :fiv_felv_status, :atom do
      constraints one_of: [:both_negative, :both_positive]
    end

    attribute :health_status, :atom do
      constraints one_of: [:healthy, :sick]
    end

    attribute :castrated, :boolean
  end
end
