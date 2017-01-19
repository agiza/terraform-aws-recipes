 [
  {
    "name": "${service_name}",
    "image": "${ecr_image}",
    "cpu": 500,
    "memory": 450,
    "essential": true,
    "logConfiguration": {
       "logDriver": "awslogs",
       "options": {
           "awslogs-group": "${log_group_name}",
           "awslogs-region": "${region}",
           "awslogs-stream-prefix": "${log_stream_prefix}"
       }
    },
    "environment": [
       {
         "name": "REGION",
         "value": "${region}"
       },
       {
         "name": "ENVIRONMENT",
         "value": "${environment}"
       },
       {
         "name": "DECRYPTION_REGION",
         "value": "${kms_region}"
       },
       {
         "name": "DATACENTER",
         "value": "${datacenter}"
       }
     ],
    "family": "${service_name}"
  }
]
