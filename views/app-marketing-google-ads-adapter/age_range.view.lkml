include: "criteria_base.view"
include: "/views/adwords_config.view"

view: age_range_adapter {
  extends: [adwords_config, criteria_base]
  sql_table_name: {{ criteria.adwords_schema._sql }}.age_range ;;

  dimension: criteria {
    label: "Age Range"
  }
}
