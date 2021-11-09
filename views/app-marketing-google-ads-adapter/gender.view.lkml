include: "criteria_base.view"

view: gender_adapter {
  extends: [adwords_config, criteria_base]
  sql_table_name: {{ criteria.adwords_schema._sql }}.gender ;;

  dimension: criteria {
    label: "Gender"
  }
}
