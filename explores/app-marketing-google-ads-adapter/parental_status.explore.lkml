include: "/views/*.view"
include: "/explores/**/*.explore"

explore: parental_status_adapter {
  persist_with: adwords_etl_datagroup
  extends: [criteria_joins_base]
  from: parental_status_adapter
  view_label: "Parental Status"
  view_name: criteria
  hidden: yes
}
