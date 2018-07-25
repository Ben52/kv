defmodule KV.Bucket do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %{} end)
  end

  def put(bucket, key, val) do
    Agent.update(bucket, &Map.put(&1, key, val))
  end

  def get(bucket, key) do
    Agent.get(bucket, &Map.get(&1, key))
  end

  def delete(bucket, key) do
    Agent.get_and_update(bucket, &Map.pop(&1, key))
  end

  def has?(bucket, key) do
    get(bucket, key) !== nil
  end
end
