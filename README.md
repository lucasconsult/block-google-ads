# Google Ads Block
## What Does This Block Do For Me? ##

This block contains views, explores and dashboards used for analysis in Looker of exported Google Ads data. It is modeled on the schema from Fivetrans's [Google Ads ETL](https://fivetran.com/directory/google-ads) brought over with Looker-specific connector (https://fivetran.com/integrations/adwords_for_looker).
The schema documentation for Ads can be found in [Google's docs](https://developers.google.com/adwords/api/docs/appendix/reports).

#### Account Structure

ad.view:
 - ad_adapter
   - external_customer_id
   - campaign_id
   - ad_group_id
   - creative_id
   - creative
   - status_active

ad_group.view:
 - ad_group_adapter
   - external_customer_id
   - campaign_id
   - ad_group_id
   - ad_group_name
   - status_active

campaign.view:
 - campaign_adapter
   - external_customer_id
   - campaign_id
   - campaign_name
   - status_active
   - budget_id
   - amount

customer.view:
 - customer_adapter
   - external_customer_id

#### Targeting Criteria
geo.view
 - geotargeting
   - state
   - country_code
   - name
   - postal_code

keyword.view
 - keyword_adapter
   - external_customer_id
   - campaign_id
   - ad_group_id
   - criterion_id
   - criteria
   - status_active
   - bidding_strategy_type

#### Reports

ad_impressions.view
 - _date
 - ad_network_type
 - device_type
 - cost
 - impressions
 - interactions
 - clicks
 - conversions
 - conversionvalue
 - averageposition

Account Stats
 - ad_impressions_adapter
 - ad_impressions_hour_adapter
   - hour_of_day

Campaign Stats
 - ad_impressions_campaign_adapter
 - ad_impressions_campaign_hour_adapter
   - hour_of_day

Ad Group Stats
 - ad_impressions_ad_group_adapter
 - ad_impressions_ad_group_hour_adapter
   - hour_of_day

Keyword Stats
 - ad_impressions_keyword_adapter

Ad Stats
 - ad_impressions_ad_adapter

Targeting Reports
 - ad_impressions * [age_range, audience, gender, geo, parental_status, video]


## Installation ##
This block is installed via the Looker Marketplace. For more information about the Looker Marketplace, please visit this [link](https://docs.looker.com/data-modeling/marketplace).

#### Constants ####
During installation you will provide two values to populate the following constants:
* Connection Name - the Looker connection with access to and permission to retrieve data from your Google Ads tables.
* Google Ads Schema - the schema name for your exported Google Ads data.

#### Customization ####
- This block uses Refinements to allow for modification or extension of the LookML content. For more information on using refinements to customize marketplace blocks, please see [this documentation](https://docs.looker.com/data-modeling/marketplace/customize-blocks).
