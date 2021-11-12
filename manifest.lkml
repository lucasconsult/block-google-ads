project_name: "block-google-ads"

constant: CONNECTION_NAME {
  value: "4mile_snowflake_db_fivetran"
  # value: "looker_app_2"
  export: override_optional
}

constant: GOOGLE_ADS_SCHEMA {
  value: "ADWORDS"
  export: override_optional
}
