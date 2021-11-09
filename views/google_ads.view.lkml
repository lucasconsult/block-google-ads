# Google Ads configuration for Google Ads Block by Looker

include: "/views/app-marketing-google-ads-adapter/*.view"
include: "/views/app-marketing-google-ads/*.view"
include: "/views/app-marketing-common/*.view"

# Customize measure definitions in this view. Changes will be reflected across all projects.

view: ad_metrics_base {
  extends: [ad_metrics_base_template]
}

view: ad {
  extends: [ad_adapter]
}

view: keyword {
  extends: [keyword_adapter]
}

view: ad_group {
  extends: [ad_group_adapter]
}

view: campaign {
  extends: [campaign_adapter]
}

view: customer {
  extends: [customer_adapter]
}

view: google_ad_metrics_base {
  extends: [google_ad_metrics_base_template]
}

view: ad_impressions {
  extends: [ad_impressions_template]
}

view: ad_impressions_daily {
  extends: [ad_impressions_daily_template]
}

view: ad_impressions_campaign {
  extends: [ad_impressions_campaign_template]
}

view: ad_impressions_campaign_daily {
  extends: [ad_impressions_campaign_daily_template]
}

view: ad_impressions_ad_group_hour {
  extends: [ad_impressions_ad_group_hour_template]
}

view: ad_impressions_ad_group {
  extends: [ad_impressions_ad_group_template]
}

view: ad_impressions_keyword {
  extends: [ad_impressions_keyword_template]
}

view: ad_impressions_ad {
  extends: [ad_impressions_ad_template]
}

view: ad_impressions_geo {
  extends: [ad_impressions_geo_template]
}

view: ad_impressions_age_range {
  extends: [ad_impressions_age_range_template]
}

view: ad_impressions_gender {
  extends: [ad_impressions_gender_template]
}

view: ad_impressions_audience {
  extends: [ad_impressions_audience_template]
}

view: ad_impressions_parental_status {
  extends: [ad_impressions_parental_status_template]
}

view: ad_impressions_video {
  extends: [ad_impressions_video_template]
}

view: adwords_period_comparison {
  extends: [period_fact]
}
