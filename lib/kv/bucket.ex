defmodule KV.Bucket do
  use Agent

  @doc """
  Starts a new bucket.
  """
  def start_link(_opts) do
    Agent.start_link(fn -> %{} end)
  end

  @doc """
  Gets a value from the `bucket` by `key`.
  """
  def get(bucket, key) do
    Agent.get(bucket, fn dict ->
      Map.get(dict, key)
    end)
  end

  @doc """
  Puts the `value` for the given `key` in the `bucket`.
  """
  # def put(bucket, key, value) do
  #   Agent.update(bucket, &Map.put(&1, key, value))
  # end
  def put(bucket, key, value) do
    Agent.update(bucket, fn dict ->
      Map.put(dict, key, value)
    end)
  end

  @doc """
  Deletes `key` from `bucket`.

  Returns the current value of `key`, if `key` exists.
  """
  def delete(bucket, key) do
    Agent.get_and_update(bucket, fn dict ->
      Map.pop(dict, key)
    end)
  end
end
