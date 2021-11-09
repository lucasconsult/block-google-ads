view: adwords_config {
  extension: required

# Should remain hidden as it's not intended to be used as a column.
  dimension: adwords_schema {
    hidden: yes
    sql:@{GOOGLE_ADS_SCHEMA};;
  }
}
