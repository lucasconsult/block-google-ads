include: "/views/*.view"
include: "/explores/**/*.explore"

explore: keyword_join {
  extension: required

  join: keyword {
    from: keyword_adapter
    view_label: "Keyword"
    sql_on: ${fact.criterion_id} = ${keyword.criterion_id} AND
      ${fact.ad_group_id} = ${keyword.ad_group_id} AND
      ${fact.campaign_id} = ${keyword.campaign_id} AND
      ${fact.external_customer_id} = ${keyword.external_customer_id} AND
      ${fact._date} = ${keyword._date} ;;
    relationship: many_to_one
  }
}

explore: keyword {
  persist_with: adwords_etl_datagroup
  from: keyword_adapter
  view_name: keyword
  hidden: yes

  join: ad_group {
    from: ad_group
    view_label: "Ad Groups"
    sql_on: ${keyword.ad_group_id} = ${ad_group.ad_group_id} AND
      ${keyword.campaign_id} = ${ad_group.campaign_id} AND
      ${keyword.external_customer_id} = ${ad_group.external_customer_id} AND
      ${keyword._date} = ${ad_group._date} ;;
    relationship: many_to_one
  }
  join: campaign {
    from: campaign
    view_label: "Campaign"
    sql_on: ${keyword.campaign_id} = ${campaign.campaign_id} AND
      ${keyword.external_customer_id} = ${campaign.external_customer_id} AND
      ${keyword._date} = ${campaign._date};;
    relationship: many_to_one
  }
  join: customer {
    from: customer
    view_label: "Customer"
    sql_on: ${keyword.external_customer_id} = ${customer.external_customer_id} AND
      ${keyword._date} = ${customer._date} ;;
    relationship: many_to_one
  }
}
