defmodule Kotkowo.Accounts.User do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [AshAuthentication, AshGraphql.Resource],
    authorizers: [Ash.Policy.Authorizer]

  policies do
    policy action(:sign_in_with_password) do
      authorize_if always()
    end

    policy action(:current_user) do
      authorize_if actor_present()
    end
  end

  graphql do
    type :user

    queries do
      read_one(:current_user, :current_user) do
        allow_nil? true
      end

      get :sign_in_with_password, :sign_in_with_password do
        type_name(:user_with_token)
        identity(false)
        as_mutation?(true)
      end
    end
  end

  attributes do
    uuid_primary_key :id
    attribute :email, :ci_string, allow_nil?: false

    attribute :hashed_password, :string,
      allow_nil?: false,
      sensitive?: true,
      private?: true
  end

  actions do
    defaults [:read]

    read :current_user do
      manual Kotkowo.ManualFetchUser
    end
  end

  code_interface do
    define_for Kotkowo.Accounts
    define :register, action: :register_with_password, args: [:email, :password, :password_confirmation]
  end

  authentication do
    api Kotkowo.Accounts

    strategies do
      password :password do
        identity_field :email
      end
    end

    tokens do
      enabled? true
      token_resource Kotkowo.Accounts.Token

      signing_secret fn _, _ ->
        Application.fetch_env(:kotkowo, :token_signing_secret)
      end
    end
  end

  postgres do
    table "users"
    repo Kotkowo.Repo
  end

  identities do
    identity :unique_email, [:email]
  end
end
