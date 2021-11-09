include: "/views/*.view"
include: "/explores/**/*.explore"

explore: criteria_joins_base {
  extension: required
  hidden: yes
  view_name: criteria

  join: ad_group {
    from: ad_group
    view_label: "Ad Groups"
    sql_on: ${criteria.ad_group_id} = ${ad_group.ad_group_id} AND
      ${criteria.campaign_id} = ${ad_group.campaign_id} AND
      ${criteria.external_customer_id} = ${ad_group.external_customer_id} AND
      ${criteria._date} = ${ad_group._date} ;;
    relationship: many_to_one
  }
  join: campaign {
    from: campaign
    view_label: "Campaign"
    sql_on: ${criteria.campaign_id} = ${campaign.campaign_id} AND
      ${criteria.external_customer_id} = ${campaign.external_customer_id} AND
      ${criteria._date} = ${campaign._date};;
    relationship: many_to_one
  }
  join: customer {
    from: customer
    view_label: "Customer"
    sql_on: ${criteria.external_customer_id} = ${customer.external_customer_id} AND
      ${criteria._date} = ${customer._date} ;;
    relationship: many_to_one
  }
}
