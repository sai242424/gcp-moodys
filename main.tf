provider "google" {
  project = "bq-poc-323317"
  region = "us-central1"
}


resource "google_pubsub_topic" "stream1" {
  name = "bq-poc-notification"

  message_retention_duration = "86600s"
}


resource "google_bigquery_table" "ingestion" {
  dataset_id = "json_test"
  table_id   = "bq_poc_moodys_news_ingestion"

  time_partitioning {
    type = "MONTH"
  }

  labels = {
    env = "default"
  }

  schema = <<EOF
[
  {
    "name": "version",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "version"
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
    "name": "deckline",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "deckline"
  },
  {
    "name": "summary",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "summary"
  },
  {
    "name": "story_link",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "story_link"
  },
  {
    "name": "copyright_line",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "copyright_line"
  },
  {
    "name": "language",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "language"
  },
  {
    "name": "date_published",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "date_published"
  },
  {
    "name": "date_received",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "date_received"
  },
  {
    "name": "published_reason",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "published_reason"
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
    "name": "codes",
    "type": "RECORD",
	"mode": "NULLABLE",
    "fields" : [
	{
		"name": "subject",
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
			"type": "STRING"
			"mode": "REPEATED"
		}
		]
	},	
	{	
		"name": "industry",
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
		"name": "company",
		"type": "RECORD",
		"mode": "REPEATED",
		"fields" : [
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
  },
  {
	"name": "organizations",
	"type": "RECORD",
	"mode": "REPEATED",
	"fields" : [
	{
		"name": "name",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "importance",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "reason_for_tagging",
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
	},	
	{
		"name": "other_identifiers",
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
	},	
	{
		"name": "adr_ticker",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "parent_indicator",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "adr_ticker_indicator",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "mic_exchange_code",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "ticker_hierarchy",
		"type": "STRING",
		"mode": "NULLABLE"
	}
	]
  },
  {
	"name": "issuer",
	"type": "STRING",
	"mode": "NULLABLE"
  },
  {
	"name": "market_grouping",
	"type": "RECORD",
	"mode": "REPEATED",
	"fields" :  [
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
	"name": "people",
	"type": "RECORD",
	"mode": "REPEATED",
	"fields" :  [
	{
		"name": "code",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "name",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "affiliation",
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
	},
	{
		"name": "other_identifiers",
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
	"name": "locations",
	"type": "RECORD",
	"mode": "NULLABLE",
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
	},
	{
		"name": "location",
		"type": "RECORD",
		"mode": "NULLABLE",
		"fields": [
		{
			"name": "lat",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "lon",
			"type": "STRING",
			"mode": "NULLABLE"
		}
		]
	}
	]
  },	
  {
	"name": "feed_information",
	"type": "RECORD",
	"mode": "NULLABLE",
	"fields" : [
	{
		"name": "provider",
		"type": "RECORD",
		"mode": "NULLABLE",
		"fields" : [
	    {
		    "name": "name",
		    "type": "STRING",
		    "mode": "NULLABLE"
	    },
	    {
		    "name": "code",
		    "type": "STRING",
		    "mode": "NULLABLE"
		}
		]
	},
	{
		"name": "service",
		"type": "RECORD",
		"mode": "NULLABLE",
		"fields" : [
	    {
		    "name": "name",
		    "type": "STRING",
		    "mode": "NULLABLE"
	    },
	    {
		    "name": "code",
		    "type": "STRING",
		    "mode": "NULLABLE"
	    }
		]	
	},
	{
		"name": "source",
		"type": "RECORD",
		"mode": "NULLABLE",
		"fields" : [
	    {
		    "name": "code",
		    "type": "STRING",
		    "mode": "NULLABLE"
	    },
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
		    "name": "type",
		    "type": "RECORD",
		    "mode": "NULLABLE",
			"fields" : [
		    {
				"name": "code",
				"type": "STRING",
				"mode": "NULLABLE"
		    },
		    {
				"name": "name",
				"type": "STRING",
				"mode": "NULLABLE"
			}
			]
		},
		{
			"name": "subject",
			"type": "RECORD",
			"mode": "NULLABLE",
			"fields" : [
		    {
		      "name": "code",
		      "type": "STRING",
		      "mode": "NULLABLE"
		    },
		    {
		      "name": "name",
		      "type": "STRING",
		      "mode": "NULLABLE"
			}
			]
		},
		{
			"name": "industry",
			"type": "RECORD",
			"mode": "NULLABLE",
			"fields" : [
		    {
		      "name": "code",
		      "type": "STRING",
		      "mode": "NULLABLE"
		    },
		    {
		      "name": "name",
		      "type": "STRING",
		      "mode": "NULLABLE"
			}
			]
		},
		{
			"name": "topness",
		    "type": "STRING",
		    "mode": "NULLABLE"
		},
		{
		   "name": "rights",
		   "type": "RECORD",
		   "mode": "NULLABLE",
			"fields" : [
		    {
				"name": "code",
				"type": "STRING",
				"mode": "NULLABLE"
		    },
		    {
				"name": "name",
				"type": "STRING",
				"mode": "NULLABLE"
			}
			]
		},
		{
		   "name": "media_type",
		   "type": "RECORD",
		   "mode": "NULLABLE",
			"fields" : [
		    {
				"name": "code",
				"type": "STRING",
				"mode": "NULLABLE"
		    },
		    {
				"name": "name",
				"type": "STRING",
				"mode": "NULLABLE"
			}
			]
		},
		{
		   "name": "geographic_origin",
		   "type": "RECORD",
		   "mode": "REPEATED",
			"fields" : [
		    {
				"name": "code",
				"type": "STRING",
				"mode": "NULLABLE"
		    },
		    {
				"name": "long_name",
				"type": "STRING",
				"mode": "NULLABLE"
			},
			{
				"name": "short_name",
				"type": "STRING",
				"mode": "NULLABLE"
			}
			]
		},
		{
		   "name": "geographic_focus",
		   "type": "RECORD",
		   "mode": "REPEATED",
			"fields" : [
		    {
				"name": "code",
				"type": "STRING",
				"mode": "NULLABLE"
		    },
		    {
				"name": "long_name",
				"type": "STRING",
				"mode": "NULLABLE"
			},
			{
				"name": "short_name",
				"type": "STRING",
				"mode": "NULLABLE"
			}
			]
		]
		},
	},	
	{
		"name": "packages",
		"type": "STRING",
		"mode": "REPEATED" 
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
		"name": "label",
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
	"name": "data",
	"type": "RECORD",
	"mode": "REPEATED",
	"fields" : [
	{
		"name": "type",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "list",
		"type": "RECORD",
		"mode": "REPEATED",
		"fields": [ 
		{
			"name": "name",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "id",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "date",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "values",
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
		"name": "type",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "id",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "date",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "values",
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
  },
  {
	"name": "body",
	"type": "STRING",
	"mode": "NULLABLE" 
  }
]
EOF

}

resource "google_bigquery_table" "final" {
  dataset_id = "json_test"
  table_id   = "bq_poc_moodys_news_final"

  time_partitioning {
    type = "MONTH"
	field = "date_published"
  }

  labels = {
    env = "default"
  }

  schema = <<EOF
[
  {
    "name": "version",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "version"
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
    "name": "deckline",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "deckline"
  },
  {
    "name": "summary",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "summary"
  },
  {
    "name": "story_link",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "story_link"
  },
  {
    "name": "copyright_line",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "copyright_line"
  },
  {
    "name": "language",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "language"
  },
  {
    "name": "date_published",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "date_published"
  },
  {
    "name": "date_received",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "date_received"
  },
  {
    "name": "published_reason",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "published_reason"
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
    "name": "codes",
    "type": "RECORD",
	"mode": "NULLABLE",
    "fields" : [
	{
		"name": "subject",
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
			"type": "STRING"
			"mode": "REPEATED"
		}
		]
	},	
	{	
		"name": "industry",
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
		"name": "company",
		"type": "RECORD",
		"mode": "REPEATED",
		"fields" : [
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
  },
  {
	"name": "organizations",
	"type": "RECORD",
	"mode": "REPEATED",
	"fields" : [
	{
		"name": "name",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "importance",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "reason_for_tagging",
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
	},	
	{
		"name": "other_identifiers",
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
	},	
	{
		"name": "adr_ticker",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "parent_indicator",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "adr_ticker_indicator",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "mic_exchange_code",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "ticker_hierarchy",
		"type": "STRING",
		"mode": "NULLABLE"
	}
	]
  },
  {
	"name": "issuer",
	"type": "STRING",
	"mode": "NULLABLE"
  },
  {
	"name": "market_grouping",
	"type": "RECORD",
	"mode": "REPEATED",
	"fields" :  [
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
	"name": "people",
	"type": "RECORD",
	"mode": "REPEATED",
	"fields" :  [
	{
		"name": "code",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "name",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "affiliation",
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
	},
	{
		"name": "other_identifiers",
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
	"name": "locations",
	"type": "RECORD",
	"mode": "NULLABLE",
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
	},
	{
		"name": "location",
		"type": "RECORD",
		"mode": "NULLABLE",
		"fields": [
		{
			"name": "lat",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "lon",
			"type": "STRING",
			"mode": "NULLABLE"
		}
		]
	}
	]
  },	
  {
	"name": "feed_information",
	"type": "RECORD",
	"mode": "NULLABLE",
	"fields" : [
	{
		"name": "provider",
		"type": "RECORD",
		"mode": "NULLABLE",
		"fields" : [
	    {
		    "name": "name",
		    "type": "STRING",
		    "mode": "NULLABLE"
	    },
	    {
		    "name": "code",
		    "type": "STRING",
		    "mode": "NULLABLE"
		}
		]
	},
	{
		"name": "service",
		"type": "RECORD",
		"mode": "NULLABLE",
		"fields" : [
	    {
		    "name": "name",
		    "type": "STRING",
		    "mode": "NULLABLE"
	    },
	    {
		    "name": "code",
		    "type": "STRING",
		    "mode": "NULLABLE"
	    }
		]	
	},
	{
		"name": "source",
		"type": "RECORD",
		"mode": "NULLABLE",
		"fields" : [
	    {
		    "name": "code",
		    "type": "STRING",
		    "mode": "NULLABLE"
	    },
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
		    "name": "type",
		    "type": "RECORD",
		    "mode": "NULLABLE",
			"fields" : [
		    {
				"name": "code",
				"type": "STRING",
				"mode": "NULLABLE"
		    },
		    {
				"name": "name",
				"type": "STRING",
				"mode": "NULLABLE"
			}
			]
		},
		{
			"name": "subject",
			"type": "RECORD",
			"mode": "NULLABLE",
			"fields" : [
		    {
		      "name": "code",
		      "type": "STRING",
		      "mode": "NULLABLE"
		    },
		    {
		      "name": "name",
		      "type": "STRING",
		      "mode": "NULLABLE"
			}
			]
		},
		{
			"name": "industry",
			"type": "RECORD",
			"mode": "NULLABLE",
			"fields" : [
		    {
		      "name": "code",
		      "type": "STRING",
		      "mode": "NULLABLE"
		    },
		    {
		      "name": "name",
		      "type": "STRING",
		      "mode": "NULLABLE"
			}
			]
		},
		{
			"name": "topness",
		    "type": "STRING",
		    "mode": "NULLABLE"
		},
		{
		   "name": "rights",
		   "type": "RECORD",
		   "mode": "NULLABLE",
			"fields" : [
		    {
				"name": "code",
				"type": "STRING",
				"mode": "NULLABLE"
		    },
		    {
				"name": "name",
				"type": "STRING",
				"mode": "NULLABLE"
			}
			]
		},
		{
		   "name": "media_type",
		   "type": "RECORD",
		   "mode": "NULLABLE",
			"fields" : [
		    {
				"name": "code",
				"type": "STRING",
				"mode": "NULLABLE"
		    },
		    {
				"name": "name",
				"type": "STRING",
				"mode": "NULLABLE"
			}
			]
		},
		{
		   "name": "geographic_origin",
		   "type": "RECORD",
		   "mode": "REPEATED",
			"fields" : [
		    {
				"name": "code",
				"type": "STRING",
				"mode": "NULLABLE"
		    },
		    {
				"name": "long_name",
				"type": "STRING",
				"mode": "NULLABLE"
			},
			{
				"name": "short_name",
				"type": "STRING",
				"mode": "NULLABLE"
			}
			]
		},
		{
		   "name": "geographic_focus",
		   "type": "RECORD",
		   "mode": "REPEATED",
			"fields" : [
		    {
				"name": "code",
				"type": "STRING",
				"mode": "NULLABLE"
		    },
		    {
				"name": "long_name",
				"type": "STRING",
				"mode": "NULLABLE"
			},
			{
				"name": "short_name",
				"type": "STRING",
				"mode": "NULLABLE"
			}
			]
		]
		},
	},	
	{
		"name": "packages",
		"type": "STRING",
		"mode": "REPEATED" 
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
		"name": "label",
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
	"name": "data",
	"type": "RECORD",
	"mode": "REPEATED",
	"fields" : [
	{
		"name": "type",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "list",
		"type": "RECORD",
		"mode": "REPEATED",
		"fields": [ 
		{
			"name": "name",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "id",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "date",
			"type": "STRING",
			"mode": "NULLABLE"
		},
		{
			"name": "values",
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
		"name": "type",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "id",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "date",
		"type": "STRING",
		"mode": "NULLABLE"
	},
	{
		"name": "values",
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
  },
  {
	"name": "body",
	"type": "STRING",
	"mode": "NULLABLE" 
  }
]
EOF

}