include: "/views/*.view"
include: "/explores/**/*.explore"

explore: audience_adapter {
  persist_with: adwords_etl_datagroup
  extends: [criteria_joins_base]
  from: audience_adapter
  view_label: "Audience"
  view_name: criteria
  hidden: yes
}
