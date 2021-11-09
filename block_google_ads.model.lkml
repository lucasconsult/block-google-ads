connection: "@{CONNECTION_NAME}"

include: "/dashboards/*.dashboard"
include: "/views/*.view"
include: "/views/app-marketing-common/*.view"
include: "/explores/**/*.explore"

datagroup: adwords_etl_datagroup {
  sql_trigger: SELECT COUNT(*) FROM `@{GOOGLE_ADS_SCHEMA}.account_hourly_stats` ;;
  max_cache_age: "24 hours"
}

# Daily Account Aggregation
explore: ad_impressions {
  extends: [ad_impressions_template]
  hidden: yes
}

explore: ad_impressions_daily {
  extends: [ad_impressions_daily_template]
  hidden: yes
}


explore: ad_impressions_campaign {
  extends: [ad_impressions_campaign_template]
  group_label: "Block Adwords"
}

explore: ad_impressions_campaign_daily {
  extends: [ad_impressions_campaign_daily_template]
  hidden: yes
}

explore: ad_impressions_ad_group {
  extends: [ad_impressions_ad_group_template]
  hidden: yes
}

explore: ad_impressions_ad_group_hour {
  extends: [ad_impressions_ad_group_hour_template]
  hidden: yes
}

explore: ad_impressions_ad {
  extends: [ad_impressions_ad_template]
  hidden: no
  group_label: "Block Adwords"
}

explore: ad_impressions_keyword {
  extends: [ad_impressions_keyword_template]
  hidden: yes
}

explore: ad_impressions_geo {
  extends: [ad_impressions_geo_template]
  hidden: yes
}

explore: ad_impressions_age_range {
  extends: [ad_impressions_age_range_template]
  hidden: yes
}

explore: ad_impressions_gender {
  extends: [ad_impressions_gender_template]
  hidden: yes
}

explore: ad_impressions_audience {
  extends: [ad_impressions_audience_template]
  hidden: yes
}

explore: ad_impressions_parental_status {
  extends: [ad_impressions_parental_status_template]
  hidden: yes
}

explore: ad_impressions_video {
  extends: [ad_impressions_video_template]
  hidden: yes
}

explore: adwords_period_comparison {
  extends: [period_fact]
}
