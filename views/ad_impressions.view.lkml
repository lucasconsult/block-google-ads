include: "/views/**/*.view"



view: ad_impressions {
  extends: [ad_impressions_base, ad_impressions_adapter]
}
view: ad_impressions_daily {
  extends: [ad_impressions_base, ad_impressions_daily_adapter]
}
view: ad_impressions_campaign {
  extends: [ad_impressions_base, ad_impressions_campaign_adapter]
}
view: ad_impressions_campaign_daily {
  extends: [ad_impressions_base, ad_impressions_campaign_daily_adapter]
}
view: ad_impressions_ad_group_hour {
  extends: [ad_impressions_base, ad_impressions_ad_group_hour_adapter]
}
view: ad_impressions_ad_group {
  extends: [ad_impressions_base, ad_impressions_ad_group_adapter]
}
view: ad_impressions_keyword {
  extends: [ad_impressions_base, ad_impressions_keyword_adapter]
}
view: ad_impressions_ad {
  extends: [ad_impressions_base, ad_impressions_keyword_adapter]
  sql_table_name: {{ fact.adwords_schema._sql }}.ad_stats ;;

  dimension: ad_primary_key {
    hidden: yes
    sql: concat(${keyword_primary_key}, "|", ${creative_id_string}, "|", ${is_negative_string}) ;;
  }

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: ${ad_primary_key} ;;
  }

  dimension: criterion_id {
    hidden: yes
    sql: ${TABLE}.criterion_id ;;
  }

  dimension: criterion_type {
    hidden: yes
    sql: ${TABLE}.criterion_type ;;
  }

  dimension: creative_id {
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: creative_id_string {
    hidden: yes
    sql: CAST(${TABLE}.id as STRING) ;;
  }

  dimension: is_negative {
    hidden: yes
    type: yesno
    sql: ${TABLE}.is_negative ;;
  }

  dimension: is_negative_string {
    hidden: yes
    sql: CAST(${TABLE}.is_negative AS STRING) ;;
  }
}
view: ad_impressions_geo {
  extends: [ad_impressions_base, ad_impressions_geo_adapter]


  measure: average_click_rate {
    link: {
      label: "By Keyword"
      url: "/explore/marketing_analytics/ad_impressions?fields=keyword.criteria,fact.average_click_rate&f[fact.date_date]=this quarter"
    }
    html:  {% if (geo_us_state.state._in_query) %}
        <a href= "/embed/explore/marketing_analytics/ad_impressions_geo?fields=fact.average_click_rate,geo_us_postal_code.postal_code&f[geo_us_postal_code_state.state]={{geo_us_state.state._value | url_encode}}&sorts=fact.average_click_rate+desc&toggle=vis&vis=%7B%22type%22%3A%22looker_map%22%2C%22map_plot_mode%22%3A%22points%22%2C%22heatmap_gridlines%22%3Afalse%2C%22heatmap_gridlines_empty%22%3Afalse%2C%22heatmap_opacity%22%3A0.5%2C%22show_region_field%22%3Atrue%2C%22draw_map_labels_above_data%22%3Atrue%2C%22map_tile_provider%22%3A%22positron%22%2C%22map_position%22%3A%22fit_data%22%2C%22map_scale_indicator%22%3A%22off%22%2C%22map_pannable%22%3Atrue%2C%22map_zoomable%22%3Atrue%2C%22map_marker_type%22%3A%22circle%22%2C%22map_marker_icon_name%22%3A%22default%22%2C%22map_marker_radius_mode%22%3A%22proportional_value%22%2C%22map_marker_units%22%3A%22meters%22%2C%22map_marker_proportional_scale_type%22%3A%22linear%22%2C%22map_marker_color_mode%22%3A%22fixed%22%2C%22show_view_names%22%3Atrue%2C%22show_legend%22%3Atrue%2C%22quantize_map_value_colors%22%3Afalse%2C%22reverse_map_value_colors%22%3Afalse%7D&filter_config=%7B%22geo_us_postal_code_state.state%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22{{ geo_us_state.state._value | url_encode }}%22%7D%2C%7B%7D%5D%2C%22id%22%3A0%2C%22error%22%3Afalse%7D%5D%7D"> {{rendered_value}}  </a>
        {% else %} {{rendered_value}}
        {% endif %};;
  }
  measure: average_conversion_rate {
    html: {% if (geo_us_state.state._in_query) %}
        <a href= "/embed/explore/marketing_analytics/ad_impressions_geo?fields=fact.average_conversion_rate,geo_us_postal_code.postal_code&f[geo_us_postal_code_state.state]={{ geo_us_state.state._value | url_encode }}&sorts=fact.average_click_rate+desc&toggle=vis&vis=%7B%22type%22%3A%22looker_map%22%2C%22map_plot_mode%22%3A%22points%22%2C%22heatmap_gridlines%22%3Afalse%2C%22heatmap_gridlines_empty%22%3Afalse%2C%22heatmap_opacity%22%3A0.5%2C%22show_region_field%22%3Atrue%2C%22draw_map_labels_above_data%22%3Atrue%2C%22map_tile_provider%22%3A%22positron%22%2C%22map_position%22%3A%22fit_data%22%2C%22map_scale_indicator%22%3A%22off%22%2C%22map_pannable%22%3Atrue%2C%22map_zoomable%22%3Atrue%2C%22map_marker_type%22%3A%22circle%22%2C%22map_marker_icon_name%22%3A%22default%22%2C%22map_marker_radius_mode%22%3A%22proportional_value%22%2C%22map_marker_units%22%3A%22meters%22%2C%22map_marker_proportional_scale_type%22%3A%22linear%22%2C%22map_marker_color_mode%22%3A%22fixed%22%2C%22show_view_names%22%3Atrue%2C%22show_legend%22%3Atrue%2C%22quantize_map_value_colors%22%3Afalse%2C%22reverse_map_value_colors%22%3Afalse%7D&filter_config=%7B%22geo_us_postal_code_state.state%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22{{ geo_us_state.state._value | url_encode }}%22%7D%2C%7B%7D%5D%2C%22id%22%3A0%2C%22error%22%3Afalse%7D%5D%7D"> {{rendered_value}}  </a>
        {% else %} {{rendered_value}}
        {% endif %} ;;
  }
  measure: average_cost_per_click {
    html:  {% if (geo_us_state.state._in_query) %}
        <a href= "/embed/explore/marketing_analytics/ad_impressions_geo?fields=fact.average_cost_per_click,geo_us_postal_code.postal_code&f[geo_us_postal_code_state.state]={{geo_us_state.state._value | url_encode}}&sorts=fact.average_click_rate+desc&toggle=vis&vis=%7B%22type%22%3A%22looker_map%22%2C%22map_plot_mode%22%3A%22points%22%2C%22heatmap_gridlines%22%3Afalse%2C%22heatmap_gridlines_empty%22%3Afalse%2C%22heatmap_opacity%22%3A0.5%2C%22show_region_field%22%3Atrue%2C%22draw_map_labels_above_data%22%3Atrue%2C%22map_tile_provider%22%3A%22positron%22%2C%22map_position%22%3A%22fit_data%22%2C%22map_scale_indicator%22%3A%22off%22%2C%22map_pannable%22%3Atrue%2C%22map_zoomable%22%3Atrue%2C%22map_marker_type%22%3A%22circle%22%2C%22map_marker_icon_name%22%3A%22default%22%2C%22map_marker_radius_mode%22%3A%22proportional_value%22%2C%22map_marker_units%22%3A%22meters%22%2C%22map_marker_proportional_scale_type%22%3A%22linear%22%2C%22map_marker_color_mode%22%3A%22fixed%22%2C%22show_view_names%22%3Atrue%2C%22show_legend%22%3Atrue%2C%22quantize_map_value_colors%22%3Afalse%2C%22reverse_map_value_colors%22%3Afalse%7D&filter_config=%7B%22geo_us_postal_code_state.state%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22{{ geo_us_state.state._value | url_encode }}%22%7D%2C%7B%7D%5D%2C%22id%22%3A0%2C%22error%22%3Afalse%7D%5D%7D"> {{rendered_value}}  </a>
        {% else %} {{rendered_value}}
        {% endif %};;
  }
  measure: average_cost_per_conversion {
    drill_fields: [fact.date_date, campaign.name, fact.total_conversions]
    html:  {% if (geo_us_state.state._in_query) %}
        <a href= "/embed/explore/marketing_analytics/ad_impressions_geo?fields=fact.average_cost_per_conversion,geo_us_postal_code.postal_code&f[geo_us_postal_code_state.state]={{geo_us_state.state._value | url_encode}}&sorts=fact.average_click_rate+desc&toggle=vis&vis=%7B%22type%22%3A%22looker_map%22%2C%22map_plot_mode%22%3A%22points%22%2C%22heatmap_gridlines%22%3Afalse%2C%22heatmap_gridlines_empty%22%3Afalse%2C%22heatmap_opacity%22%3A0.5%2C%22show_region_field%22%3Atrue%2C%22draw_map_labels_above_data%22%3Atrue%2C%22map_tile_provider%22%3A%22positron%22%2C%22map_position%22%3A%22fit_data%22%2C%22map_scale_indicator%22%3A%22off%22%2C%22map_pannable%22%3Atrue%2C%22map_zoomable%22%3Atrue%2C%22map_marker_type%22%3A%22circle%22%2C%22map_marker_icon_name%22%3A%22default%22%2C%22map_marker_radius_mode%22%3A%22proportional_value%22%2C%22map_marker_units%22%3A%22meters%22%2C%22map_marker_proportional_scale_type%22%3A%22linear%22%2C%22map_marker_color_mode%22%3A%22fixed%22%2C%22show_view_names%22%3Atrue%2C%22show_legend%22%3Atrue%2C%22quantize_map_value_colors%22%3Afalse%2C%22reverse_map_value_colors%22%3Afalse%7D&filter_config=%7B%22geo_us_postal_code_state.state%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22{{ geo_us_state.state._value | url_encode }}%22%7D%2C%7B%7D%5D%2C%22id%22%3A0%2C%22error%22%3Afalse%7D%5D%7D"> {{rendered_value}}  </a>
        {% else %} {{rendered_value}}
        {% endif %};;
  }
}
view: ad_impressions_age_range {
  extends: [ad_impressions_base, ad_impressions_age_range_adapter]
}
view: ad_impressions_gender {
  extends: [ad_impressions_base, ad_impressions_gender_adapter]
}
view: ad_impressions_audience {
  extends: [ad_impressions_base, ad_impressions_audience_adapter]
}
view: ad_impressions_parental_status {
  extends: [ad_impressions_base, ad_impressions_parental_status_adapter]
}
view: ad_impressions_video {
  extends: [ad_impressions_base, ad_impressions_video_adapter]
}

# Multi Use Base
view: ad_impressions_base {
  extension: required
  extends: [date_base, period_base, google_ad_metrics_base]
}
view: ad_impressions_adapter_base {
  extension: required
  extends: [adwords_config, google_adwords_base, transformations_base, google_ad_metrics_base]

  dimension: account_primary_key {
    hidden: yes
    sql: concat(
      ${date_string}, "|",
      ${external_customer_id_string}, "|",
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

# Derived Tables
view: ad_impressions_derived_table {
  extension: required
  derived_table: {
    datagroup_trigger: adwords_etl_datagroup
    explore_source: ad_impressions_daily {
      column: date { field: fact._date }
      column: external_customer_id { field: fact.external_customer_id }
      column: ad_network_type_1 { field: fact.ad_network_type1 }
      column: ad_network_type_2 { field: fact.ad_network_type2 }
      column: device { field: fact.device }
      column: clicks {field: fact.total_clicks }
      column: conversions {field: fact.total_conversions}
      column: conversion_value {field: fact.total_conversionvalue}
      column: cost {field: fact.total_cost}
      column: impressions { field: fact.total_impressions}
      column: interactions {field: fact.total_interactions}
    }
  }
}
view: ad_impressions_campaign_derived_table {
  extension: required
  derived_table: {
    datagroup_trigger: adwords_etl_datagroup
    explore_source: ad_impressions_campaign_daily {
      column: date { field: fact._date }
      column: external_customer_id { field: fact.external_customer_id }
      column: campaign_id { field: fact.campaign_id }
      column: ad_network_type_1 { field: fact.ad_network_type1 }
      column: ad_network_type_2 { field: fact.ad_network_type2 }
      column: device { field: fact.device }
      column: clicks {field: fact.total_clicks }
      column: conversions {field: fact.total_conversions}
      column: conversion_value {field: fact.total_conversionvalue}
      column: cost {field: fact.total_cost}
      column: impressions { field: fact.total_impressions}
      column: interactions {field: fact.total_interactions}
    }
  }
}
view: ad_impressions_ad_group_derived_table {
  extension: required
  derived_table: {
    datagroup_trigger: adwords_etl_datagroup
    explore_source: ad_impressions_ad_group_daily {
      column: date { field: fact._date }
      column: external_customer_id { field: fact.external_customer_id }
      column: campaign_id { field: fact.campaign_id }
      column: ad_group_id { field: fact.ad_group_id }
      column: ad_network_type_1 { field: fact.ad_network_type1 }
      column: ad_network_type_2 { field: fact.ad_network_type2 }
      column: device { field: fact.device }
      column: clicks {field: fact.total_clicks }
      column: conversions {field: fact.total_conversions}
      column: conversion_value {field: fact.total_conversionvalue}
      column: cost {field: fact.total_cost}
      column: impressions { field: fact.total_impressions}
      column: interactions {field: fact.total_interactions}
    }
  }
}

# Multi Use Adapter
view: ad_impressions_adapter {
  extends: [ad_impressions_derived_table, ad_impressions_adapter_base]
}
view: ad_impressions_daily_adapter {
  extends: [ad_impressions_adapter_base]
  sql_table_name: {{ fact.adwords_schema._sql }}.account_stats ;;

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: concat(${account_primary_key}, "|", ${date_string}) ;;
  }
}
view: ad_impressions_campaign_adapter {
  extends: [ad_impressions_campaign_derived_table, ad_impressions_campaign_adapter_base]
}
view: ad_impressions_campaign_daily_adapter {
  extends: [ad_impressions_campaign_adapter_base, date_hour_base]
  sql_table_name: {{ fact.adwords_schema._sql }}.campaign_stats ;;

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: concat(${campaign_primary_key}, "|", ${date_string}) ;;
  }
}
view: ad_impressions_ad_group_adapter {
  extends: [ad_impressions_ad_group_derived_table, ad_impressions_ad_group_adapter_base]
}
view: ad_impressions_ad_group_hour_adapter {
  extends: [ad_impressions_ad_group_adapter_base, date_hour_base]
  sql_table_name: {{ fact.adwords_schema._sql }}.ad_group_hourly_stats ;;

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: concat(${ad_group_primary_key}, "|", ${hour_of_day_string}) ;;
  }
}
view: ad_impressions_ad_group_daily_adapter {
  extends: [ad_impressions_ad_group_adapter_base, date_hour_base]
  sql_table_name: {{ fact.adwords_schema._sql }}.ad_group_stats ;;

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: concat(${ad_group_primary_key}, "|", ${date_string}) ;;
  }
}
view: ad_impressions_keyword_adapter {
  extends: [ad_impressions_ad_group_adapter_base]
  sql_table_name: {{ fact.adwords_schema._sql }}.keyword_stats ;;

  dimension: keyword_primary_key {
    hidden: yes
    sql: concat(${ad_group_primary_key}, "|", ${criterion_id_string}, "|", ${slot}) ;;
  }

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: ${keyword_primary_key} ;;
  }

  dimension: criterion_id {
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: criterion_id_string {
    hidden: yes
    sql: CAST(${TABLE}.id as STRING) ;;
  }

  dimension: slot {
    hidden: yes
    type: string
    sql: ${TABLE}.slot ;;
  }
}
view: ad_impressions_ad_adapter {
  extends: [ad_impressions_keyword_adapter]
}
view: ad_impressions_ad_conversion_adapter {
  extends: [adwords_config, google_adwords_base, transformations_base, ad_metrics_conversion_base_adapter]
  sql_table_name: {{ fact.adwords_schema._sql }}.ad_conversion_stats ;;

  dimension: ad_conversion_primary_key {
    hidden: yes
    sql: concat(
      ${date_string}, "|",
      ${external_customer_id_string}, "|",
      ${ad_network_type1}, "|",
      ${ad_network_type2}, "|",
      ${device}, "|",
      ${campaign_id_string}, "|",
      ${ad_group_id_string}, "|",
      ${criterion_id_string}, "|",
      ${slot}, "|",
      ${creative_id_string}, "|",
      ${is_negative_string}, "|",
      ${conversion_category_name}, "|",
      ${conversion_tracker_id}, "|",
      ${conversion_type_name},) ;;
  }

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: ${ad_conversion_primary_key} ;;
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

  dimension: criterion_id {
    hidden: yes
    sql: ${TABLE}.criterion_id ;;
  }

  dimension: criterion_id_string {
    hidden: yes
    sql: CAST(${TABLE}.criterion_id as STRING) ;;
  }

  dimension: slot {
    hidden: yes
    type: string
    sql: ${TABLE}.slot ;;
  }

  dimension: is_negative {
    hidden: yes
    type: yesno
    sql: ${TABLE}.is_negative ;;
  }

  dimension: is_negative_string {
    hidden: yes
    sql: CAST(${TABLE}.is_negative AS STRING) ;;
  }

  dimension: creative_id {
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: creative_id_string {
    hidden: yes
    sql: CAST(${TABLE}.id as STRING) ;;
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

  dimension: conversion_category_name {
    hidden: yes
    type: string
    sql: ${TABLE}.conversion_category_name ;;
  }

  dimension: conversion_tracker_id {
    hidden: yes
    type: number
    sql: ${TABLE}.conversion_tracker_id ;;
  }

  dimension: conversion_type_name {
    type: string
    sql: ${TABLE}.conversion_type_name ;;
    label: "Conversion Type"
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

  dimension: device {
    hidden: yes
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension: view_through_conversions {
    hidden: yes
    type: number
    sql: ${TABLE}.view_through_conversions ;;
  }

  measure: custom_conversions {
    type: sum
    sql: ${TABLE}.conversions ;;
    description: "Custom Conversions"
    value_format_name: decimal_0
  }

  measure: custom_conversion_value {
    type: sum
    sql: ${TABLE}.conversion_value ;;
    description: "Custom Conversions"
    value_format_name: usd_0
  }

}
view: ad_impressions_geo_adapter {
  extends: [ad_impressions_ad_group_adapter]
  sql_table_name: {{ fact.adwords_schema._sql }}.geo_stats ;;

  dimension: city_criteria_id {
    hidden: yes
    type: number
    sql: ${TABLE}.city_criteria_id;;
  }

  dimension: country_criteria_id {
    hidden: yes
    type: number
    sql: ${TABLE}.country_criteria_id ;;
  }

  dimension: metro_criteria_id {
    hidden: yes
    type: number
    sql: ${TABLE}.metro_criteria_id ;;
  }

  dimension: most_specific_criteria_id {
    hidden: yes
    type: number
    sql: ${TABLE}.most_specific_criteria_id ;;
  }

  dimension: region_criteria_id {
    hidden: yes
    type: number
    sql: ${TABLE}.region_criteria_id ;;
  }
}
view: ad_impressions_age_range_adapter {
  extends: [ad_impressions_keyword_adapter]
  sql_table_name: {{ fact.adwords_schema._sql }}.age_range_stats ;;
}
view: ad_impressions_audience_adapter {
  extends: [ad_impressions_keyword_adapter]
  sql_table_name: {{ fact.adwords_schema._sql }}.audience_stats ;;
}
view: ad_impressions_gender_adapter {
  extends: [ad_impressions_keyword_adapter]
  sql_table_name: {{ fact.adwords_schema._sql }}.gender_stats ;;
}
view: ad_impressions_parental_status_adapter {
  extends: [ad_impressions_keyword_adapter]
  sql_table_name: {{ fact.adwords_schema._sql }}.parental_status_stats ;;
}
view: ad_impressions_video_adapter {
  extends: [adwords_config, google_adwords_base, transformations_base]
  sql_table_name: {{ fact.adwords_schema._sql }}.video_stats ;;

  dimension: ad_group_id {
    hidden: yes
  }

  dimension: ad_group_id_string {
    hidden: yes
    sql: CAST(${ad_group_id} as STRING) ;;
  }

  dimension: ad_network_type1 {
    hidden: yes
    sql: ${TABLE}.ad_network_type_1 ;;
  }

  dimension: ad_network_type2 {
    hidden: yes
    sql: ${TABLE}.ad_network_type_2 ;;
  }

  dimension: campaign_id {
    hidden: yes
  }

  dimension: campaign_id_string {
    hidden: yes
    sql: CAST(${campaign_id} as STRING) ;;
  }

  dimension: clicks {
    hidden: yes
    type: number
  }

  dimension: conversions {
    hidden: yes
    type: number
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

  dimension: creative_id {
    hidden: yes
  }

  dimension: creative_id_string {
    hidden: yes
    sql: CAST(${creative_id} as STRING) ;;
  }

  dimension: creative_status {
    hidden: yes
  }

  dimension: device {
    hidden: yes
  }

  dimension: impressions {
    hidden: yes
    type: number
  }

  dimension: video_id {
    hidden: yes
  }

  dimension: video_channel_id {
    hidden: yes
  }

  dimension: view_through_conversions {
    hidden: yes
    type: number
  }
}
view: audience_adapter {
  extends: [adwords_config, criteria_base]
  sql_table_name: {{ criteria.adwords_schema._sql }}.audience ;;

  dimension: criteria {
    label: "Audience"
  }

  dimension: user_list_name {}
}
view: ad_metrics_conversion_base_adapter {
  extension: required

  measure: total_conversions {
    hidden: yes
    label: "Conversions"
    description: "Total conversions."
    type: sum
    sql: ${conversions} ;;
    value_format_name: decimal_0
  }

  measure: total_conversionvalue {
    hidden: yes
    label: "Conv. Value"
    description: "Total conversion value."
    type: sum
    sql: ${conversionvalue} ;;
    value_format_name: usd_0
  }

  measure: average_value_per_conversion {
    hidden: yes
    label: "Value per Conversion"
    description: "Average value per conversion."
    type: number
    sql: ${total_conversionvalue}*1.0 / NULLIF(${total_conversions},0) ;;
    value_format_name: usd
  }

  measure: average_cost_per_conversion {
    hidden: yes
    label: "Cost per Conversion"
    description: "Cost per conversion."
    type: number
    sql: ${fact.total_cost}*1.0 / NULLIF(${total_conversions},0) ;;
    value_format_name: usd
  }

  measure: average_value_per_click {
    hidden: yes
    label: "Value per Click"
    description: "Average value per ad click."
    type: number
    sql: ${total_conversionvalue}*1.0 / NULLIF(${fact.total_clicks},0) ;;
    value_format_name: usd
  }

  measure: average_value_per_impression {
    hidden: yes
    label: "Value per Impression"
    description: "Average value per ad impression viewed."
    type: number
    sql: ${total_conversionvalue}*1.0 / NULLIF(${fact.total_impressions},0) ;;
    value_format_name: usd
  }

  measure: average_value_per_cost {
    hidden: yes
    label: "ROAS"
    description: "Average Return on Ad Spend."
    type: number
    sql: ${total_conversionvalue}*1.0 / NULLIF(${fact.total_cost},0) ;;
    value_format_name: percent_0
  }

  measure: average_conversion_rate {
    hidden: yes
    label: "Conversion Rate"
    description: "Percent of people that convert after they interact with an ad."
    type: number
    sql: ${total_conversions}*1.0 / NULLIF(${fact.total_clicks},0) ;;
    value_format_name: percent_2
  }
}
view: age_range_adapter {
  extends: [adwords_config, criteria_base]
  sql_table_name: {{ criteria.adwords_schema._sql }}.age_range ;;

  dimension: criteria {
    label: "Age Range"
  }
}
view: gender_adapter {
  extends: [adwords_config, criteria_base]
  sql_table_name: {{ criteria.adwords_schema._sql }}.gender ;;

  dimension: criteria {
    label: "Gender"
  }
}
view: parental_status_adapter {
  extends: [adwords_config, criteria_base]
  sql_table_name: {{ criteria.adwords_schema._sql }}.parental_status ;;

  dimension: criteria {
    label: "Parental Status"
  }
}
view: video_adapter {
  extends: [adwords_config, google_adwords_base]
  sql_table_name: {{ video.adwords_schema._sql }}.video ;;

  dimension: ad_group_id {
    hidden: yes
    type: number
  }

  dimension: campaign_id {
    hidden: yes
    type: number
  }

  dimension: video_duration {
    type: number
  }

  dimension: video_id {
    hidden: yes
    type: string
  }

  dimension: video_title {
    type: string
  }
}
