include: "/views/*.view"
include: "/explores/**/*.explore"

explore: campaign_join {
  extension: required

  join: campaign {
    from: campaign
    view_label: "Campaign"
    sql_on: ${fact.campaign_id} = ${campaign.campaign_id} AND
      ${fact.external_customer_id} = ${campaign.external_customer_id} AND
      ${fact._date} = ${campaign._date} ;;
    relationship: many_to_one
  }
}

explore: campaign {
  persist_with: adwords_etl_datagroup
  from: campaign
  view_name: campaign
  hidden: yes

  join: customer {
    from: customer
    view_label: "Customer"
    sql_on: ${campaign.external_customer_id} = ${customer.external_customer_id} AND
      ${campaign._date} = ${customer._date} ;;
    relationship: many_to_one
  }
}
