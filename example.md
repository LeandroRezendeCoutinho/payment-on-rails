## Config register example

```bash
curl --request POST \
  --url http://localhost:3000/clients \
  --header 'Content-Type: application/json' \
  --header 'User-Agent: insomnia/2023.5.8' \
  --data '{
	"client": {
		"name": "John Doe"
	}
}'
```

```bash
curl --request POST \
  --url http://localhost:3000/integrations \
  --header 'Content-Type: application/json' \
  --header 'User-Agent: insomnia/2023.5.8' \
  --data '{
  "integration": {
		"name": "teste",
		"config": {
			"provider": {
				"name": "teste",
				"baseUrl": "http://localhost",
				"payment_path": "/payments",
				"auth_path": "",
				"auth_method": "",
				"credentials": {
					"user": "user"
				}
			},
			"mapping": [
				{
					"from": "amount",
					"to":   "amount"
				},
				{
					"from": "capture",
					"to":   "capture"
				},
				{
					"from": "status",
					"to":   "status"
				},
				{
					"from": "order_id",
					"to":   "order_id"
				},
				{
					"from": "payment_type",
					"to":   "payment_type"
				},
				{
					"from": "source_type",
					"to":   "source_type"
				}
			]	
		},
		"client_id": 1
	}
}
'
```