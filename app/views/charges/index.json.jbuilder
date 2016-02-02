json.array!(@charges) do |charge|
  json.extract! charge, :id, :amount, :designer_uid, :customer_token, :customer_id, :designer_id
  json.url charge_url(charge, format: :json)
end
