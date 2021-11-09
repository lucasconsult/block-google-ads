include: "/views/*.view"
include: "/explores/**/*.explore"

explore: campaign_budget_date_fact {
  persist_with: adwords_etl_datagroup
  hidden: yes
  label: "Campaign Budget Date Fact"
  view_label: "Campaign Budget Date Fact"
  from: campaign_budget_date_fact
  view_name: fact
  join: customer {
    from: customer
    view_label: "Customer"
    sql_on: ${fact.external_customer_id} = ${customer.external_customer_id} AND
      ${fact._date} = ${customer._date} ;;
    relationship: many_to_one
  }
  join: campaign {
    from: campaign
    view_label: "Campaign"
    sql_on: ${fact.campaign_id} = ${campaign.campaign_id} AND
      ${fact.external_customer_id} = ${campaign.external_customer_id} AND
      ${fact._date} = ${campaign._date} ;;
    relationship: many_to_one
  }
}
