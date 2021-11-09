include: "/views/*.view"
include: "/explores/**/*.explore"

explore: age_range_adapter {
  persist_with: adwords_etl_datagroup
  extends: [criteria_joins_base]
  from: age_range_adapter
  view_label: "Age Range"
  view_name: criteria
  hidden: yes
}
