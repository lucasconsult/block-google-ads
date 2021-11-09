include: "criteria_base.view"

view: parental_status_adapter {
  extends: [adwords_config, criteria_base]
  sql_table_name: {{ criteria.adwords_schema._sql }}.parental_status ;;

  dimension: criteria {
    label: "Parental Status"
  }
}
