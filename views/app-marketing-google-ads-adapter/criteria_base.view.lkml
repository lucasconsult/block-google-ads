include: "ad_group.view"
include: "google_adwords_base.view"

view: criteria_base {
  extension: required
  extends: [google_adwords_base]

  dimension: ad_group_id {
    hidden:  yes
  }

  dimension: base_ad_group_id {
    hidden:  yes
  }

  dimension: base_campaign_id {
    hidden:  yes
  }

  dimension: bid_modifier {
    type: number
    hidden:  yes
  }

  dimension: bid_type {
    hidden:  yes
  }

  dimension: campaign_id {
    hidden:  yes
  }

  dimension: cpc_bid {
    type: number
    hidden:  yes
  }

  dimension: cpc_bid_source {
    type: string
    hidden:  yes
  }

  dimension: cpm_bid {
    type: number
    hidden:  yes
  }

  dimension: cpm_bid_source {
    hidden:  yes
  }

  dimension: criteria {}

  dimension: criteria_destination_url {
    hidden: yes
  }

  dimension: criterion_id {
    hidden:  yes
    sql: ${TABLE}.id ;;
  }

  dimension: final_app_urls {
    hidden:  yes
  }

  dimension: final_mobile_urls {
    hidden:  yes
  }

  dimension: final_urls {
    hidden:  yes
  }

  dimension: is_negative {
    type: yesno
    hidden:  yes
  }

  dimension: is_restrict {
    type: yesno
    hidden:  yes
  }

  dimension: status {
    hidden: yes
  }

  dimension: status_active {
    hidden: yes
    type: yesno
    sql: ${status} = "enabled" ;;
  }

  dimension: tracking_url_template {
    hidden:  yes
  }

  dimension: url_custom_parameters {
    hidden:  yes
  }

  dimension: key_base {
    hidden: yes
    sql: CONCAT(
      CAST(${external_customer_id} AS STRING), "-",
      CAST(${campaign_id} AS STRING), "-",
      CAST(${ad_group_id} AS STRING), "-",
      CAST(${criterion_id} AS STRING)) ;;
  }

  measure: count {
    hidden: yes
    type: count_distinct
    sql: ${key_base} ;;
    drill_fields: [drill_detail*]
  }

  measure: count_active {
    hidden: yes
    type: count_distinct
    sql: ${key_base} ;;
    filters: {
      field: status_active
      value: "Yes"
    }
    drill_fields: [drill_detail*]
  }

  set: drill_detail {
    fields: [criterion_id, criteria, status, cpc_bid]
  }
  set: detail {
    fields: [external_customer_id, campaign_id, ad_group_id, count, count_active, status_active, drill_detail*]
  }
}
