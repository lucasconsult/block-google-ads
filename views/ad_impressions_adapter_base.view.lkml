include: "/views/**/*.view"

# Multi Use Base
view: ad_impressions_adapter_base {
  extension: required
  extends: [adwords_config, google_adwords_base, transformations_base, google_ad_metrics_base]

  dimension: account_primary_key {
    hidden: yes
    sql: concat(
      ${date_string}, "|",
      ${ad_network_type1},  "|",
      ${ad_network_type2}, "|",
      ${device}) ;;
  }
  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: ${account_primary_key} ;;
  }
  dimension: active_view_impressions {
    hidden: yes
    type: number
    sql: ${TABLE}.active_view_impressions ;;
  }
  dimension: active_view_measurability {
    hidden: yes
    type: number
    sql: ${TABLE}.active_view_measurability ;;
  }
  dimension: active_view_measurable_cost {
    hidden: yes
    type: number
    sql: ${TABLE}.active_view_measurable_cost ;;
  }
  dimension: active_view_measurable_impressions {
    hidden: yes
    type: number
    sql: ${TABLE}.active_view_measurable_impressions ;;
  }
  dimension: active_view_viewability {
    hidden: yes
    type: number
    sql: ${TABLE}.active_view_viewability ;;
  }
  dimension: ad_network_type1 {
    hidden: yes
    type: string
    sql: ${TABLE}.ad_network_type_1 ;;
  }
  dimension: ad_network_type2 {
    hidden: yes
    type: string
    sql: ${TABLE}.ad_network_type_2 ;;
  }
  dimension: clicks {
    hidden: yes
    type: number
    sql: ${TABLE}.clicks ;;
  }
  dimension: conversions {
    hidden: yes
    type: number
    sql: ${TABLE}.conversions ;;
  }
  dimension: conversionvalue {
    hidden: yes
    type: number
    sql: ${TABLE}.conversion_value ;;
  }
  dimension: cost {
    hidden: yes
    type: number
    sql: ${TABLE}.cost ;;
  }
  dimension: device {
    hidden: yes
    type: string
    sql: ${TABLE}.device ;;
  }
  dimension: impressions {
    hidden: yes
    type: number
    sql: ${TABLE}.impressions ;;
  }
  dimension: interactions {
    hidden: yes
    type: number
    sql: ${TABLE}.interactions ;;
  }
  dimension: interaction_types {
    hidden: yes
    type: string
    sql: ${TABLE}.interaction_types ;;
  }
  dimension: view_through_conversions {
    hidden: yes
    type: number
    sql: ${TABLE}.view_through_conversions ;;
  }
}
view: ad_impressions_campaign_adapter_base {
  extends: [ad_impressions_adapter_base]

  dimension: campaign_primary_key {
    hidden: yes
    sql: concat(${account_primary_key}, "|", ${campaign_id_string}) ;;
  }
  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: ${campaign_primary_key} ;;
  }
  dimension: base_campaign_id {
    hidden: yes
    sql: ${TABLE}.base_campaign_id ;;
  }
  dimension: campaign_id {
    hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }
  dimension: campaign_id_string {
    hidden: yes
    sql: CAST(${TABLE}.campaign_id as STRING) ;;
  }
}
view: ad_impressions_ad_group_adapter_base {
  extension: required
  extends: [ad_impressions_campaign_adapter_base]

  dimension: ad_group_primary_key {
    hidden: yes
    sql: concat(${campaign_primary_key}, "|", ${ad_group_id_string}) ;;
  }

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: ${ad_group_primary_key} ;;
  }

  dimension: ad_group_id {
    hidden: yes
    sql: ${TABLE}.ad_group_id ;;
  }

  dimension: ad_group_id_string {
    hidden: yes
    sql: CAST(${TABLE}.ad_group_id as STRING) ;;
  }

  dimension: base_ad_group_id {
    hidden: yes
    sql: ${TABLE}.base_ad_group_id ;;
  }
}
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
    fields: [ campaign_id, ad_group_id, count, count_active, status_active, drill_detail*]
  }
}
view: date_hour_base {
  extension: required

  dimension: hour_of_day {
    hidden: yes
    type: number
    sql: ${TABLE}.hour_of_day ;;
  }

  dimension: hour_of_day_string {
    hidden: yes
    sql: CAST(${TABLE}.hour_of_day AS STRING) ;;
  }

  dimension: date_string {
    hidden: yes
    sql: CAST(${TABLE}.date AS STRING) ;;
  }

}
view: transformations_base {
  extension: required

  dimension: ad_network_type {
    hidden: yes
    type: string
    case: {
      when: {
        sql: ${ad_network_type1} = 'Search Network' AND ${ad_network_type2} = 'Google search' ;;
        label: "Search"
      }
      when: {
        sql: ${ad_network_type1} = 'Search Network' AND ${ad_network_type2} = 'Search partners' ;;
        label: "Search Partners"
      }
      when: {
        sql: ${ad_network_type1} = 'Display Network' ;;
        label: "Content"
      }
      when: {
        sql: ${ad_network_type1} = 'YouTube Videos' ;;
        label: "YouTube Videos"
      }
      when: {
        sql: ${ad_network_type1} = 'YouTube Search' ;;
        label: "YouTube Search"
      }
      else: "Other"
    }
  }

  dimension: device_type {
    hidden: yes
    type: string
    case: {
      when: {
        sql: ${device} LIKE '%Desktop%' OR ${device} LIKE '%Computers%' ;;
        label: "Desktop"
      }
      when: {
        sql: ${device} LIKE '%Mobile%' ;;
        label: "Mobile"
      }
      when: {
        sql: ${device} LIKE '%Tablet%' ;;
        label: "Tablet"
      }
      else: "Other"
    }
  }
}
