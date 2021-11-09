include: "criteria_base.view"

view: audience_adapter {
  extends: [adwords_config, criteria_base]
  sql_table_name: {{ criteria.adwords_schema._sql }}.audience ;;

  dimension: criteria {
    label: "Audience"
  }

  dimension: user_list_name {}
}
