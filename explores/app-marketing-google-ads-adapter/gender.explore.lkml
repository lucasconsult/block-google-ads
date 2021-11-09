include: "/views/*.view"
include: "/explores/**/*.explore"

explore: gender_adapter {
  persist_with: adwords_etl_datagroup
  extends: [criteria_joins_base]
  from: gender_adapter
  view_label: "Gender"
  view_name: criteria
  hidden: yes
}
