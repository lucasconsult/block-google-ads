explore: ad_group_join {
  extension: required

  join: ad_group {
    from: ad_group
    view_label: "Ad Groups"
    sql_on: ${fact.ad_group_id} = ${ad_group.ad_group_id} AND
      ${fact.campaign_id} = ${ad_group.campaign_id} AND
      ${fact.external_customer_id} = ${ad_group.external_customer_id} AND
      ${fact._date} = ${ad_group._date} ;;
    relationship: many_to_one
  }
}

explore: ad_group {
  extension: required
  persist_with: adwords_etl_datagroup
  from: ad_group
  view_name: ad_group
  hidden: yes

  join: campaign {
    from: campaign
    view_label: "Campaign"
    sql_on: ${ad_group.campaign_id} = ${campaign.campaign_id} AND
      ${ad_group.external_customer_id} = ${campaign.external_customer_id} AND
      ${ad_group._date} = ${campaign._date};;
    relationship: many_to_one
  }
  join: customer {
    from: customer
    view_label: "Customer"
    sql_on: ${ad_group.external_customer_id} = ${customer.external_customer_id} AND
      ${ad_group._date} = ${customer._date} ;;
    relationship: many_to_one
  }
}
