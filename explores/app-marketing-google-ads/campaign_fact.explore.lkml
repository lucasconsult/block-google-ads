include: "/views/*.view"
include: "/explores/**/*.explore"

explore: campaign_date_fact {
  persist_with: adwords_etl_datagroup
  extends: [account_date_fact, campaign_join]
  from: campaign_date_fact
  view_name: fact
  label: "Campaign This Period"
  view_label: "Campaign This Period"
  join: last_fact {
    from: campaign_date_fact
    view_label: "Campaign Prior Period"
    sql_on: ${fact.external_customer_id} = ${last_fact.external_customer_id} AND
      ${fact.campaign_id} = ${last_fact.campaign_id} AND
      ${fact.date_last_period} = ${last_fact.date_period} AND
      ${fact.date_day_of_period} = ${last_fact.date_day_of_period} ;;
  }
  join: parent_fact {
    view_label: "Customer This Period"
    from: account_date_fact
    sql_on: ${fact.external_customer_id} = ${parent_fact.external_customer_id} AND
      ${fact.date_date} = ${parent_fact.date_date};;
    relationship: many_to_one
  }
}
