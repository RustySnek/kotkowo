defmodule Calculations.S3Upload do
  use Ash.Calculation

  alias ExAws.S3
  alias ExAws.Config

  @impl true
  def load(_query, opts, _context) do
    opts[:segments]
  end

  @impl true
  def calculate(records, opts, %{actor: actor}) do
    if is_nil(actor) and opts[:write] do
      List.duplicate(nil, length(records))
    else
      parse_records(records, opts)
    end
  end

  defp parse_records(records, opts) do
    for record <- records do
      record_opts = record_opts(record, opts)

      if opts[:write] do
        compose_write(record_opts)
      else
        compose_read(record_opts)
      end
    end
  end

  defp record_opts(record, opts) do
    bucket = opts[:bucket]
    s3_config = Config.new(:s3)

    object =
      Enum.map_join(opts[:segments], "/", fn segment ->
        to_string(Map.get(record, segment))
      end)

    %{bucket: bucket, s3_config: s3_config, object: object}
  end

  defp compose_read(%{s3_config: s3_config, bucket: bucket, object: object}) do
    s3_config.scheme <>
      s3_config.host <> ":" <> to_string(s3_config.port) <> "/" <> bucket <> "/" <> object
  end

  defp compose_write(%{s3_config: s3_config, bucket: bucket, object: object}) do
    case S3.presigned_url(s3_config, :put, bucket, object) do
      {:ok, url} -> url
      _ -> nil
    end
  end
end
