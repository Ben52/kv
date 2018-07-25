defmodule KV.Bucket_test do
  use ExUnit.Case, async: true

  setup do
    bucket = start_supervised!(KV.Bucket)
    %{bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") === nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") === 3
  end

  test "deletes an item from the bucket", %{bucket: bucket} do
    KV.Bucket.put(bucket, "milk", 3)
    KV.Bucket.put(bucket, "banana", 90)
    KV.Bucket.put(bucket, "apples", 100)

    assert KV.Bucket.get(bucket, "banana") === 90
    assert KV.Bucket.has?(bucket, "banana") === true
    assert KV.Bucket.delete(bucket, "banana") === 90
    assert KV.Bucket.has?(bucket, "banana") === false
  end
end
