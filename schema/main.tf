provider "google" {
  project = "bq-poc-323317"
  region = "us-central1"
}


resource "google_pubsub_topic" "stream1" {
  name = "bq-poc-notification"

  message_retention_duration = "86600s"
}


resource "google_bigquery_table" "default" {
  dataset_id = "json_test"
  table_id   = "bq_poc_moddys_news_staging"

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = "default"
  }

  schema = <<EOF
[
  {
    "name": "api_version",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "api_version"
  },
  {
    "name": "resource_id",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "resource_id"
  },
  {
    "name": "headline",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "headline"
  },
  {
    "name": "summary",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "summary"
  },
  {
    "name": "date_published",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "date_published"
  },
  {
    "name": "zone_published",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "zone_published"
  },
  {
    "name": "date_received",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "date_received"
  },
  {
    "name": "zone_received",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "zone_received"
  },
  {
    "name": "published_reason",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "published_reason"
  },
  {
    "name": "deckline",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "deckline"
  },
  {
    "name": "story_language",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "story_language"
  },
  {
    "name": "images",
    "type": "RECORD",
    "mode": "REPEATED",
    "fields" : [
	{
		"name": "image_file",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "image_caption",
		"type": "STRING",
		"mode": "NULLABLE"
	}
	]	
  },
  {
    "name": "copyright_line",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "copyright_line"
  },
  {
    "name": "body",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "body"
  },
  {
    "name": "taxonomy",
    "type": "RECORD",
    "fields" : [
	{
		"name": "subject_codes",
		"type": "RECORD",
		"mode": "REPEATED",
		"fields" : [
		{
			"name": "long_name",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "short_name",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "code",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "relevance",
			"type": "STRING",
			"mode": "NULLABLE"
		}
		]		
	},
	{	
		"name": "location_codes",
		"type": "RECORD",
		"mode": "REPEATED",
		"fields" : [
		{
			"name": "long_name",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "short_name",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "code",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "relevance",
			"type": "STRING",
			"mode": "NULLABLE"
		}
		]
	},
	{	
		"name": "industry_codes",
		"type": "RECORD",
		"mode": "REPEATED",
		"fields" : [
		{
			"name": "long_name",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "short_name",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "code",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "relevance",
			"type": "STRING",
			"mode": "NULLABLE"
		}
		]	
	},
	{	
		"name": "people_codes",
		"type": "RECORD",
		"mode": "REPEATED",
		"fields" : [
		{
			"name": "long_name",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "short_name",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "code",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "relevance",
			"type": "STRING",
			"mode": "NULLABLE"
		}
		]	
	}
	]
  },
  {
	"name": "organizations",
	"type": "RECORD",
	"mode": "REPEATED",
	"fields" : [
	{
		"name": "company_name",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "importance",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "exchange",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "symbol",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "identifiers",
		"type": "RECORD",
		"mode": "REPEATED",
		"fields" :  [
		{
			"name": "name",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "value",
			"type": "STRING",
			"mode": "NULLABLE"
		}
		]
	}
	]
  },
  {
	"name": "publisher",
	"type": "RECORD",
	"fields" : [
	{
		"name": "provider_code",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "service_code",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "source",
		"type": "RECORD",
		"fields" :  [
		{
			"name": "long_name",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "short_name",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "code",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "source_type",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "geographic_origin",
			"type": "STRING",
			"mode": "REPEATED"
		},
		{
			"name": "geographic_focus",
			"type": "STRING",
			"mode": "NULLABLE"
		}
		]
	},
	{
		"name": "packages",
		"type": "STRING",
		"mode": "REPEATED"
	},
	{
		"name": "document_origin",
		"type": "RECORD",
		"fields" : [
		{
			"name": "web",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "license",
			"type": "STRING",
			"mode": "NULLABLE"
		}
		]
	}
	]
  },
  {
	"name": "vendor_data",
	"type": "RECORD",
	"mode": "REPEATED",
	"fields" : [
	{
		"name": "name_space",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "name",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "value",
		"type": "STRING",
		"mode": "NULLABLE"
	}
	]
  },	
  {
    "name": "rights",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "rights"
  },
  {
    "name": "source_topness",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "source_topness"
  },
  {
    "name": "business_relevance",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "business_relevance"
  },
  {
    "name": "cluster_signature",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "cluster_signature"
  },
  {
    "name": "headline_cluster_signature",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "headline_cluster_signature"
  },
  
  {
	"name": "story_data",
	"type": "RECORD",
	"mode": "REPEATED",
	"fields" : [
	{
		"name": "data_type",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "data_values",
		"type": "RECORD",
		"mode": "REPEATED",
		"fields": [ 
		{
			"name": "data_name",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "data_id",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "data_date",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "data_zone",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "data",
			"type": "RECORD",
			"mode": "REPEATED",
			"fields": [ 
			{
				"name": "name",
				"type": "STRING",
				"mode": "NULLABLE"
			},
			{
				"name": "value",
				"type": "STRING",
				"mode": "NULLABLE"
			}
			]
		}
		]
	}
	]
  },
  {
	"name": "signals",
	"type": "RECORD",
	"mode": "REPEATED",
	"fields" : [
	{
		"name": "signal_type",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "signal_id",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "signal_date",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "signal_zone",
		"type": "STRING",
		"mode": "NULLABLE"
	},	
	{
		"name": "data",
		"type": "RECORD",
		"mode": "REPEATED",
		"fields": [ 
		{
			"name": "name",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "value",
			"type": "STRING",
			"mode": "NULLABLE"
		}
		]
	}
	]
  }
]
EOF

}