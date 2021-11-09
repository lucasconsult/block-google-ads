include: "/views/*.view"
include: "/explores/**/*.explore"

explore: ad_impressions_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_adapter]
  from: ad_impressions
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions"
  view_label: "Impressions"
}


explore: ad_impressions_daily_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_daily_adapter]
  from: ad_impressions_daily
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Day"
  view_label: "Impressions by Day"
}

explore: ad_impressions_campaign_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_campaign_adapter]
  from: ad_impressions_campaign
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Campaign"
  view_label: "Impressions by Campaign"
}

explore: ad_impressions_campaign_daily_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_campaign_daily_adapter]
  from: ad_impressions_campaign_daily
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Campaign"
  view_label: "Impressions by Campaign"
}

explore: ad_impressions_ad_group_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_ad_group_adapter]
  from: ad_impressions_ad_group
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Ad Group"
  view_label: "Impressions by Ad Group"
}

explore: ad_impressions_ad_group_hour_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_ad_group_hour_adapter]
  from: ad_impressions_ad_group_hour
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Ad Group & Hour"
  view_label: "Impressions by Ad Group & Hour"
}

explore: ad_impressions_keyword_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_keyword_adapter]
  from: ad_impressions_keyword
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Keyword"
  view_label: "Impressions by Keyword"
}

explore: ad_impressions_ad_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_ad_adapter]
  from: ad_impressions_ad
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Ad"
  view_label: "Impressions by Ad"
}

explore: ad_impressions_geo_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_geo_adapter]
  from: ad_impressions_geo
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Geo"
  view_label: "Impressions by Geo"
}

explore: ad_impressions_age_range_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_age_range_adapter]
  from: ad_impressions_age_range
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Age Range"
  view_label: "Impressions by Age Range"
}

explore: ad_impressions_gender_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_gender_adapter]
  from: ad_impressions_gender
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Gender"
  view_label: "Impressions by Gender"
}

explore: ad_impressions_audience_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_audience_adapter]
  from: ad_impressions_audience
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Audience"
  view_label: "Impressions by Audience"
}

explore: ad_impressions_parental_status_template {
  extension: required
  persist_with: adwords_etl_datagroup
  extends: [ad_impressions_parental_status_adapter]
  from: ad_impressions_parental_status
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Parental Status"
  view_label: "Impressions by Parental Status"
}

explore: ad_impressions_video_template {
  persist_with: adwords_etl_datagroup
  extension: required
  extends: [ad_impressions_video_adapter]
  from: ad_impressions_video
  view_name: fact
  group_label: "Google Ads"
  label: "AdWord Impressions by Video"
  view_label: "Impressions by Video"
}
