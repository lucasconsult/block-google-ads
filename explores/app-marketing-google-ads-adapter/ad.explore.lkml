explore: ad_join {
  extension: required

  join: ad {
    from: ad
    view_label: "Ads"
    sql_on: ${fact.creative_id} = ${ad.creative_id} AND
      ${fact.ad_group_id} = ${ad.ad_group_id} AND
      ${fact.campaign_id} = ${ad.campaign_id} AND
      ${fact.external_customer_id} = ${ad.external_customer_id} AND
      ${fact._date} = ${ad._date} ;;
    relationship:  many_to_one
  }
}

explore: ad {
  extension: required
  persist_with: adwords_etl_datagroup
  from: ad
  view_name: ad
  hidden: yes

  join: ad_group {
    from: ad_group
    view_label: "Ad Group"
    sql_on: ${ad.ad_group_id} = ${ad_group.ad_group_id} AND
      ${ad.campaign_id} = ${ad_group.campaign_id} AND
      ${ad.external_customer_id} = ${ad_group.external_customer_id} AND
      ${ad._date} = ${ad_group._date};;
    relationship: many_to_one
  }
  join: campaign {
    from: campaign
    view_label: "Campaign"
    sql_on: ${ad.campaign_id} = ${campaign.campaign_id} AND
      ${ad.external_customer_id} = ${campaign.external_customer_id} AND
      ${ad._date} = ${campaign._date};;
    relationship: many_to_one
  }
  join: customer {
    from: customer
    view_label: "Customer"
    sql_on: ${ad.external_customer_id} = ${customer.external_customer_id} AND
      ${ad._date} = ${customer._date} ;;
    relationship: many_to_one
  }
}
