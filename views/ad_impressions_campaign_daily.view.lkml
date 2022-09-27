include: "/views/**/*.view"

view: ad_impressions_campaign_daily {
  extends: [date_base, period_base, google_ad_metrics_base, google_adwords_base]
  sql_table_name: @{GOOGLE_ADS_SCHEMA}.CampaignStats_@{GOOGLE_ADS_CUSTOMER_ID} ;;

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: concat(${campaign_primary_key}, "|", ${date_string}) ;;
  }
  dimension: campaign_primary_key {
    hidden: yes
    sql: concat(${account_primary_key}, "|", ${campaign_id_string}) ;;
  }
  dimension: base_campaign_id {
    hidden: yes
    sql: ${TABLE}.BaseCampaignId ;;
  }
  dimension: campaign_id {
    hidden: yes
    sql: ${TABLE}.CampaignId ;;
  }
  dimension: campaign_id_string {
    hidden: yes
    sql: CAST(${TABLE}.CampaignId as STRING) ;;
  }
  dimension: account_primary_key {
    hidden: yes
    sql: concat(
      ${date_string}, "|",
      ${ad_network_type1},  "|",
      ${ad_network_type2}, "|",
      ${device}) ;;
  }
  dimension: active_view_impressions {
    hidden: yes
    type: number
    sql: ${TABLE}.ActiveViewImpressions ;;
  }
  dimension: active_view_measurability {
    hidden: yes
    type: number
    sql: ${TABLE}.ActiveViewMeasurability ;;
  }
  dimension: active_view_measurable_cost {
    hidden: yes
    type: number
    sql: ${TABLE}.ActiveViewMeasurableCost ;;
  }
  dimension: active_view_measurable_impressions {
    hidden: yes
    type: number
    sql: ${TABLE}.ActiveViewMeasurableImpressions ;;
  }
  dimension: active_view_viewability {
    hidden: yes
    type: number
    sql: ${TABLE}.ActiveViewViewability ;;
  }
  dimension: ad_network_type1 {
    hidden: yes
    type: string
    sql: ${TABLE}.AdNetworkType1 ;;
  }
  dimension: ad_network_type2 {
    hidden: yes
    type: string
    sql: ${TABLE}.AdNetworkType2 ;;
  }
  dimension: clicks {
    hidden: yes
    type: number
    sql: ${TABLE}.Clicks ;;
  }
  dimension: Conversions {
    hidden: yes
    type: number
    sql: ${TABLE}.conversions ;;
  }
  dimension: conversionvalue {
    hidden: yes
    type: number
    sql: ${TABLE}.ConversionValue ;;
  }
  dimension: cost {
    hidden: yes
    type: number
    sql: ${TABLE}.Cost ;;
  }
  dimension: device {
    hidden: yes
    type: string
    sql: ${TABLE}.Device ;;
  }
  dimension: impressions {
    hidden: yes
    type: number
    sql: ${TABLE}.Impressions ;;
  }
  dimension: interactions {
    hidden: yes
    type: number
    sql: ${TABLE}.Interactions ;;
  }
  dimension: interaction_types {
    hidden: yes
    type: string
    sql: ${TABLE}.InteractionTypes ;;
  }
  dimension: view_through_conversions {
    hidden: yes
    type: number
    sql: ${TABLE}.view_through_conversions ;;
  }
}
