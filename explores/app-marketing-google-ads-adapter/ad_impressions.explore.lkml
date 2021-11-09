include: "/views/*.view"
include: "/explores/**/*.explore"

explore: ad_impressions_adapter {
  extends: [customer_join]
  from: ad_impressions_adapter
  view_name: fact
  hidden: yes
  group_label: "Google AdWords"
  label: "AdWord Impressions"
  view_label: "Impressions"
}

explore: ad_impressions_daily_adapter {
  extends: [ad_impressions_adapter]
  from: ad_impressions_daily_adapter
  view_name: fact
  group_label: "Google AdWords"
  label: "AdWord Impressions by Day"
  view_label: "Impressions by Day"
}

explore: ad_impressions_campaign_adapter {
  extends: [ad_impressions_adapter, campaign_join]
  from: ad_impressions_campaign_adapter
  view_name: fact
  group_label: "Google AdWords"
  label: "AdWord Impressions by Campaign"
  view_label: "Impressions by Campaign"
}

explore: ad_impressions_campaign_daily_adapter {
  extends: [ad_impressions_campaign_adapter]
  from: ad_impressions_campaign_daily_adapter
  view_name: fact
  group_label: "Google AdWords"
  label: "AdWord Impressions by Campaign"
  view_label: "Impressions by Campaign"
}

explore: ad_impressions_ad_group_adapter {
  extends: [ad_impressions_campaign_adapter, ad_group_join]
  from: ad_impressions_ad_group_adapter
  view_name: fact
  group_label: "Google AdWords"
  label: "AdWord Impressions by Ad Group"
  view_label: "Impressions by Ad Group"
}

explore: ad_impressions_ad_group_hour_adapter {
  extends: [ad_impressions_ad_group_adapter]
  from: ad_impressions_ad_group_hour_adapter
  view_name: fact
  group_label: "Google AdWords"
  label: "AdWord Impressions by Ad Group & Hour"
  view_label: "Impressions by Ad Group & Hour"
}

explore: ad_impressions_ad_group_daily_adapter {
  extends: [ad_impressions_ad_group_adapter]
  from: ad_impressions_ad_group_daily_adapter
  view_name: fact
  group_label: "Google AdWords"
  label: "AdWord Impressions by Ad Group"
  view_label: "Impressions by Ad Group"
}

explore: ad_impressions_keyword_adapter {
  extends: [ad_impressions_ad_group_adapter, keyword_join]
  from: ad_impressions_keyword_adapter
  view_name: fact
  group_label: "Google AdWords"
  label: "AdWord Impressions by Keyword"
  view_label: "Impressions by Keyword"
}

explore: ad_impressions_ad_adapter {
  extension: required
  extends: [ad_impressions_keyword_adapter, ad_join]
  from: ad_impressions_ad_adapter
  view_name: fact
  group_label: "Google AdWords"
  label: "AdWord Impressions by Ad"
  view_label: "Impressions by Ad"

  join: conversion {
    from: ad_impressions_ad_conversion_adapter
    view_label: "Conversions by Ad"
    sql_on: ${fact.external_customer_id} = ${conversion.external_customer_id}
      AND ${fact.campaign_id} = ${conversion.campaign_id}
      AND ${fact.ad_group_id} = ${conversion.ad_group_id}
      AND ${fact.criterion_id} = ${conversion.criterion_id}
      AND ${fact.creative_id} = ${conversion.creative_id}
      AND ${fact._date} = ${conversion._date}
      AND ${fact.slot} = ${conversion.slot}
      AND ${fact.is_negative} = ${conversion.is_negative}
      AND ${fact.device} = ${conversion.device}
      AND ${fact.ad_network_type1} = ${conversion.ad_network_type1}
      AND ${fact.ad_network_type2} = ${conversion.ad_network_type2} ;;
    relationship: one_to_many
  }
}

explore: ad_impressions_geo_adapter {
  extends: [ad_impressions_ad_group_adapter]
  from: ad_impressions_geo_adapter
  view_name: fact
  group_label: "Google AdWords"
  label: "AdWord Impressions by Geo"
  view_label: "Impressions by Geo"

  join: geo_country {
    from: geotargeting
    view_label: "Country"
    fields: [country_code]
    sql_on: ${fact.country_criteria_id} = ${geo_country.criteria_id_string} ;;
    relationship: many_to_one
  }

  join: geo_us_state {
    from: geotargeting
    view_label: "US State"
    fields: [state]
    sql_on: ${fact.region_criteria_id} = ${geo_us_state.criteria_id_string} AND
      ${geo_us_state.is_us_state} ;;
    relationship: many_to_one
    type: inner
  }

  join: geo_us_postal_code {
    from: geotargeting
    view_label: "US Postal Code"
    fields: [postal_code]
    sql_on: ${fact.most_specific_criteria_id} = ${geo_us_postal_code.criteria_id_string} AND
      ${geo_us_postal_code.is_us_postal_code} ;;
    relationship: many_to_one
    type: inner
  }

  join: geo_us_postal_code_state {
    from: geotargeting
    view_label: "US Postal Code"
    fields: [state]
    sql_on: ${geo_us_postal_code.parent_id} = ${geo_us_postal_code_state.criteria_id} AND
      ${geo_us_postal_code_state.is_us_state} ;;
    relationship: many_to_one
    type: inner
    required_joins: [geo_us_postal_code]
  }

  join: geo_region {
    from: geotargeting
    view_label: "Region"
    fields: [name, country_code]
    sql_on: ${fact.region_criteria_id} = ${geo_region.criteria_id_string} ;;
    relationship: many_to_one
  }

  join: geo_metro {
    from: geotargeting
    view_label: "Metro"
    fields: [name, country_code]
    sql_on: ${fact.metro_criteria_id} = ${geo_metro.criteria_id_string} ;;
    relationship: many_to_one
  }

  join: geo_city {
    from: geotargeting
    view_label: "City"
    fields: [name, country_code]
    sql_on: ${fact.city_criteria_id} = ${geo_city.criteria_id_string} ;;
    relationship: many_to_one
  }
}

explore: ad_impressions_age_range_adapter {
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_ad_group_adapter]
  from: ad_impressions_age_range_adapter
  view_name: fact

  join: criteria {
    from: age_range_adapter
    view_label: "Age Range"
    sql_on: ${fact.criterion_id} = ${criteria.criterion_id} AND
      ${fact.ad_group_id} = ${criteria.ad_group_id} AND
      ${fact.campaign_id} = ${criteria.campaign_id} AND
      ${fact.external_customer_id} = ${criteria.external_customer_id} AND
      ${fact._date} = ${criteria._date} ;;
    relationship: many_to_one
  }
}

explore: ad_impressions_audience_adapter {
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_ad_group_adapter]
  from: ad_impressions_audience_adapter
  view_name: fact

  join: criteria {
    from: audience_adapter
    view_label: "Audience"
    sql_on: ${fact.criterion_id} = ${criteria.criterion_id} AND
      ${fact.ad_group_id} = ${criteria.ad_group_id} AND
      ${fact.campaign_id} = ${criteria.campaign_id} AND
      ${fact.external_customer_id} = ${criteria.external_customer_id} AND
      ${fact._date} = ${criteria._date} ;;
    relationship: many_to_one
  }
}

explore: ad_impressions_gender_adapter {
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_ad_group_adapter]
  from: ad_impressions_gender_adapter
  view_name: fact

  join: criteria {
    from: gender_adapter
    view_label: "Gender"
    sql_on: ${fact.criterion_id} = ${criteria.criterion_id} AND
      ${fact.ad_group_id} = ${criteria.ad_group_id} AND
      ${fact.campaign_id} = ${criteria.campaign_id} AND
      ${fact.external_customer_id} = ${criteria.external_customer_id} AND
      ${fact._date} = ${criteria._date} ;;
    relationship: many_to_one
  }
}

explore: ad_impressions_parental_status_adapter {
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_ad_group_adapter]
  from: ad_impressions_parental_status_adapter
  view_name: fact

  join: criteria {
    from: parental_status_adapter
    view_label: "Parental Status"
    sql_on: ${fact.criterion_id} = ${criteria.criterion_id} AND
      ${fact.ad_group_id} = ${criteria.ad_group_id} AND
      ${fact.campaign_id} = ${criteria.campaign_id} AND
      ${fact.external_customer_id} = ${criteria.external_customer_id} AND
      ${fact._date} = ${criteria._date} ;;
    relationship: many_to_one
  }
}

explore: ad_impressions_video_adapter {
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_ad_group_adapter]
  from: ad_impressions_video_adapter
  view_name: fact

  join: video {
    from: video_adapter
    view_label: "Video"
    sql_on: ${fact.video_id} = ${video.video_id} AND
      ${fact.ad_group_id} = ${video.ad_group_id} AND
      ${fact.campaign_id} = ${video.campaign_id} AND
      ${fact.external_customer_id} = ${video.external_customer_id} AND
      ${fact._date} = ${video._date} ;;
    relationship: many_to_one
  }
}
