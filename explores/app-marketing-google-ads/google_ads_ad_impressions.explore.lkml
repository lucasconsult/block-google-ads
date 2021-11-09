include: "/views/*.view"
include: "/explores/**/*.explore"

explore: google_ads_ad_impressions {
  persist_with: adwords_etl_datagroup
  hidden: yes
  from: google_ads_ad_impressions
  view_name: fact
}
