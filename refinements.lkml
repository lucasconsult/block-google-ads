include: "/views/**/*.view.lkml"

view: +ad_impressions_ad {




  filter: date_range {
    hidden: yes
    type: date
    convert_tz: no
    sql: ${in_date_range} ;;
  }
  parameter: period {
    description: "Prior Period for Comparison"
    type: string
    allowed_value: {
      value: "day"
      label: "Day"
    }
    allowed_value: {
      value: "week"
      label: "Week (Mon - Sun)"
    }
    allowed_value: {
      value: "month"
      label: "Month"
    }
    allowed_value: {
      value: "quarter"
      label: "Quarter"
    }
    allowed_value: {
      value: "year"
      label: "Year"
    }
    allowed_value: {
      value: "7 day"
      label: "Last 7 Days"
    }
    allowed_value: {
      value: "28 day"
      label: "Last 28 Days"
    }
    allowed_value: {
      value: "91 day"
      label: "Last 91 Days"
    }
    allowed_value: {
      value: "364 day"
      label: "Last 364 Days"
    }
    default_value: "28 day"
  }


  dimension: _date {
    hidden: yes
    type: date_raw
    sql: CAST(${TABLE}.date AS DATE) ;;
  }

  dimension: date_string {
    hidden: yes
    sql: CAST(${TABLE}.date AS STRING) ;;
  }

  dimension: latest {
    hidden: yes
    type: yesno
    sql: 1=1 ;;
  }



  dimension_group: date {
    group_label: "Event"
    label: ""
    type: time
    datatype: date
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      day_of_week,
      day_of_week_index,
      day_of_month,
      day_of_year
    ]
    convert_tz: no
    sql: CAST(${_date} as DATE) ;;
  }
  dimension: date_week_date {
    group_label: "Event"
    label: "Week Date"
    hidden: yes
    type: date
    convert_tz: no
    sql: CAST(${date_week} AS DATE) ;;
  }
  dimension: date_month_date {
    group_label: "Event"
    label: "Month Date"
    hidden: yes
    type: date
    convert_tz: no
    sql: DATE_TRUNC(${date_date}, MONTH) ;;
  }
  dimension: date_quarter_date {
    group_label: "Event"
    label: "Quarter Date"
    hidden: yes
    type: date
    convert_tz: no
    sql: DATE_TRUNC(${date_date}, QUARTER) ;;
  }
  dimension: date_year_date {
    group_label: "Event"
    label: "Year Date"
    hidden: yes
    type: date
    convert_tz: no
    sql: DATE_TRUNC(${date_date}, YEAR) ;;
  }
  dimension: date_day_of_quarter {
    group_label: "Event"
    label: "Day of Quarter"
    hidden: yes
    type: number
    sql: DATEDIFF('day',${date_date}, ${date_quarter_date})  ;;
  }
  dimension: date_last_week {
    group_label: "Event"
    label: "Last Week"
    hidden: yes
    type: date
    convert_tz: no
    sql: DATE_ADD({date_date}, interval 7 day) ;;
  }
  dimension: date_last_month {
    group_label: "Event"
    label: "Last Month"
    hidden: yes
    type: date
    convert_tz: no
    sql: DATE_ADD(${date_date}, interval 1 month);;
  }
  dimension: date_last_quarter {
    group_label: "Event"
    label: "Last Quarter"
    hidden: yes
    type: date
    convert_tz: no
    sql: DATE_ADD(${date_date}, interval 1 quarter) ;;
  }
  dimension: date_next_week {
    hidden: yes
    type: date
    convert_tz: no
    sql:  DATE_ADD(${date_date}, interval 7 days);;
  }
  dimension: date_next_month {
    hidden: yes
    type: date
    convert_tz: no
    sql: DATE_ADD(${date_date}, interval 1 month) ;;
  }
  dimension: date_next_quarter {
    hidden: yes
    type: date
    convert_tz: no
    sql: DATE_ADD(${date_date}, interval 1 quarter) ;;
  }
  dimension: date_next_year {
    hidden: yes
    type: date
    convert_tz: no
    sql: DATE_ADD(${date_date}, interval 1 year) ;;
  }
  dimension: date_last_year {
    hidden: yes
    type: date
    convert_tz: no
    sql: DATE_ADD(${date_date}, interval 7 day) ;;
  }
  dimension: date_days_prior {
    hidden: yes
    type: number
    sql: DATEDIFF('day',${date_date}, CURRENT_DATE()) ;;
  }
  dimension: date_day_of_7_days_prior {
    hidden: yes
    type: number
    sql: MOD(MOD(${date_days_prior}, 7) + 7, 7) ;;
  }
  dimension: date_day_of_28_days_prior {
    hidden: yes
    type: number
    sql: MOD(MOD(${date_days_prior}, 28) + 28, 28) ;;
  }
  dimension: date_day_of_91_days_prior {
    hidden: yes
    type: number
    sql: MOD(MOD(${date_days_prior}, 91) + 91, 91) ;;
  }
  dimension: date_day_of_364_days_prior {
    hidden: yes
    type: number
    sql: MOD(MOD(${date_days_prior}, 364) + 364, 364) ;;
  }
  dimension: date_date_7_days_prior {
    hidden: yes
    type: date
    convert_tz: no
    sql: DATE_ADD(${date_date}, interval -${date_day_of_7_days_prior} day) ;;
  }
  dimension: date_date_28_days_prior {
    hidden: yes
    type: date
    convert_tz: no
    sql: DATE_ADD(${date_date}, interval -${date_day_of_28_days_prior} day) ;;
  }
  dimension: date_date_91_days_prior {
    hidden: yes
    type: date
    convert_tz: no
    sql: DATE_ADD(${date_date}, interval -${date_day_of_91_days_prior} day) ;;
  }
  dimension: date_date_364_days_prior {
    hidden: yes
    type: date
    convert_tz: no
    sql: DATE_ADD(${date_date} interval -${date_day_of_364_days_prior} day) ;;
  }

  dimension: date_start_date_range {
    hidden: yes
    type: date
    convert_tz: no
    sql: {% date_start date_range %} ;;
  }
  dimension: date_end_date_range {
    hidden: yes
    type: date
    convert_tz: no
    sql: {% date_end date_range %} ;;
  }
  dimension: date_range_difference {
    hidden: yes
    type: number
    sql: DATEDIFF('day',${date_end_date_range}, ${date_start_date_range}) ;;
#     expression: diff_days(${date_end_date_range}, ${date_start_date_range}) ;;
  }
  dimension: in_date_range {
    hidden: yes
    type: yesno
    sql: {% condition date_range %}CAST(${fact.date_raw} AS TIMESTAMP){% endcondition %} ;;
  }
  dimension: date_range_day_of_range_prior {
    hidden: yes
    type: number
    sql: MOD(MOD(${date_days_prior}, ${date_range_difference}) + ${date_range_difference}, ${date_range_difference}) ;;
#     expression: mod(mod(${date_days_prior},  ${date_range_difference}) +  ${date_range_difference},  ${date_range_difference}) ;;
  }
  dimension: date_range_days_prior {
    hidden: yes
    type: date
    convert_tz: no
    sql: DATE_ADD(${date_date}, interval -${date_range_day_of_range_prior} day) ;;
#     expression: add_days(-1 * ${date_range_difference}, ${date_date}) ;;
  }
  dimension: date_period {
    type: date
    convert_tz: no
    label_from_parameter: period
    group_label: "Event"
    sql: ({% if fact.period._parameter_value contains "day" %}
        {% if fact.period._parameter_value == "'7 day'" %}${date_date_7_days_prior}
        {% elsif fact.period._parameter_value == "'28 day'" %}${date_date_28_days_prior}
        {% elsif fact.period._parameter_value == "'91 day'" %}${date_date_91_days_prior}
        {% elsif fact.period._parameter_value == "'364 day'" %}${date_date_364_days_prior}
        {% else %}${date_date}
        {% endif %}
        {% elsif fact.period._parameter_value contains "week" %}${date_week}
        {% elsif fact.period._parameter_value contains "month" %}${date_month_date}
        {% elsif fact.period._parameter_value contains "quarter" %}${date_quarter_date}
        {% elsif fact.period._parameter_value contains "year" %}${date_year_date}
      {% endif %}) ;;
    allow_fill: no
  }
  dimension: date_end_of_period {
    type: date
    convert_tz: no
    label_from_parameter: period
    group_label: "Event"
    sql: ({% if fact.period._parameter_value contains "day" %}
        {% if fact.period._parameter_value == "'7 day'" %}DATE_ADD(${date_period}, interval 7 day)
        {% elsif fact.period._parameter_value == "'28 day'" %}DATE_ADD(${date_period}, interval 28 day)
        {% elsif fact.period._parameter_value == "'91 day'" %}DATE_ADD(${date_period}, interval 91 day)
        {% elsif fact.period._parameter_value == "'364 day'" %}DATE_ADD(${date_period}, interval 364 day)
        {% else %}DATE_ADD(${date_date}, interval 1 day)
        {% endif %}
        {% elsif fact.period._parameter_value contains "week" %}DATE_ADD(${date_period}, interval 7 day)
        {% elsif fact.period._parameter_value contains "month" %}DATE_ADD(${date_period}, interval 1 month)
        {% elsif fact.period._parameter_value contains "quarter" %}DATE_ADD(${date_period}, interval 1 quarter)
        {% elsif fact.period._parameter_value contains "year" %}DATE_ADD(${date_period}, interval 1 year)
        {% endif %}) ;;
    allow_fill: no
  }
  dimension: date_period_latest {
    type: yesno
    group_label: "Event"
    sql: ${date_period} < CURRENT_DATE() AND ${date_end_of_period} >= CURRENT_DATE() ;;
    # expression: ${date_period} < now() AND ${date_end_of_period} >= now() ;;
  }
  dimension: date_period_before_latest {
    type: yesno
    group_label: "Event"
    sql: ${date_period} < CURRENT_DATE() ;;
    # expression: ${date_period} < now() ;;
  }
  dimension: date_period_comparison_period {
    hidden: yes
    description: "Is the selected period (This Period) in the last two periods?"
    type: yesno
    group_label: "Event"
    sql: ${date_period} >=
      {% if period._parameter_value contains "day" %}
        {% if period._parameter_value == "'7 day'" %}DATE_ADD(CURRENT_DATE(), interval -2*7 day)
        {% elsif period._parameter_value == "'28 day'" %}DATE_ADD(CURRENT_DATE(), interval -2*28 day)
        {% elsif period._parameter_value == "'91 day'" %}DATE_ADD(CURRENT_DATE(), interval -2*91 day)
        {% elsif period._parameter_value == "'364 day'" %}DATE_ADD(CURRENT_DATE(), interval -2*364 day)
        {% else %}DATE_ADD(CURRENT_DATE(), interval -2*1 day)
        {% endif %}
      {% elsif period._parameter_value contains "week" %}DATE_ADD(CURRENT_DATE(), interval -7 day)
      {% elsif period._parameter_value contains "month" %}DATE_ADD(CURRENT_DATE(), interval -2 month)
      {% elsif period._parameter_value contains "quarter" %}DATE_ADD(CURRENT_DATE(), interval -2 quarter)
      {% elsif period._parameter_value contains "year" %}DATE_ADD(CURRENT_DATE(), interval -2 year)
      {% endif %} ;;
  }
  dimension: date_period_dynamic_grain {
    datatype: date
    hidden: yes
    type: date
    convert_tz: no
    group_label: "Event"
    label: "{% if fact.period._parameter_value contains 'year'
    or fact.period._parameter_value contains '364 day' %}Month{% elsif fact.period._parameter_value contains 'quarter'
    or fact.period._parameter_value contains '91 day' %}Week{% else %}Date{% endif %}"
    sql: {% if fact.period._parameter_value contains 'year'
        or fact.period._parameter_value contains '364 day' %}${date_month_date}
      {% elsif fact.period._parameter_value contains 'quarter'
        or fact.period._parameter_value contains '91 day' %}${date_week}
      {% else %} ${date_raw}
      {% endif %} ;;
    allow_fill: no
  }
  dimension: date_day_of_period {
    hidden: yes
    type: number
    label: "{% if fact.period._parameter_value contains 'day' %}Day of Period
    {% elsif fact.period._parameter_value contains 'week' %}Day of Week
    {% elsif fact.period._parameter_value contains 'month' %}Day of Month
    {% elsif fact.period._parameter_value contains 'quarter' %}Day of Quarter
    {% elsif fact.period._parameter_value contains 'year' %}Day of Year
    {% endif %}"
    group_label: "Event"
    sql: {% if fact.period._parameter_value contains "day" %}
        {% if fact.period._parameter_value == "'7 day'" %}${date_day_of_7_days_prior}
        {% elsif fact.period._parameter_value == "'28 day'" %}${date_day_of_28_days_prior}
        {% elsif fact.period._parameter_value == "'91 day'" %}${date_day_of_91_days_prior}
        {% elsif fact.period._parameter_value == "'364 day'" %}${date_day_of_364_days_prior}
        {% else %}0
        {% endif %}
        {% elsif fact.period._parameter_value contains "week" %}${date_day_of_week_index}
        {% elsif fact.period._parameter_value contains "month" %}${date_day_of_month}
        {% elsif fact.period._parameter_value contains "quarter" %}${date_day_of_quarter}
        {% elsif fact.period._parameter_value contains "year" %}${date_day_of_year}
        {% endif %} ;;
    # html: {{ value | plus: 1 }} - {{ date_date }};;
    # required_fields: [date_date]
    }
    dimension: date_last_period {
      group_label: "Event"
      label: "Prior Period"
      type: date
      convert_tz: no
      sql: DATE_ADD(
        ${date_period}, interval
       -{% if fact.period._parameter_value == "'7 day'" %}7
        {% elsif fact.period._parameter_value == "'28 day'" %}28
        {% elsif fact.period._parameter_value == "'91 day'" %}91
        {% elsif fact.period._parameter_value == "'364 day'" %}364
        {% else %}1
        {% endif %},
        {% if fact.period._parameter_value contains "day" %}'day'
        {% elsif fact.period._parameter_value contains "week" %}'day'
        {% elsif fact.period._parameter_value contains "month" %}'month'
        {% elsif fact.period._parameter_value contains "quarter" %}'quarter'
        {% elsif fact.period._parameter_value contains "year" %}'year'
        {% endif %}) ;;
      allow_fill: no
    }

    dimension: criterion_id_string {
      hidden: yes
      sql: CAST(${TABLE}.CriterionId as STRING) ;;
    }
    dimension: slot {
      hidden: yes
      type: string
      sql: ${TABLE}.Slot ;;
    }
    dimension: ad_group_primary_key {
      hidden: yes
      sql: concat(${campaign_primary_key}, "|", ${ad_group_id_string}) ;;
    }
    dimension: campaign_primary_key {
      hidden: yes
      sql: concat(${account_primary_key}, "|", ${campaign_id_string}) ;;
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
    dimension: device {
      hidden: yes
      type: string
      sql: ${TABLE}.Device ;;
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
    dimension: ad_group_id {
      hidden: yes
      sql: ${TABLE}.AdGroupId ;;
    }
    dimension: ad_group_id_string {
      hidden: yes
      sql: CAST(${TABLE}.AdGroupId as STRING) ;;
    }
    dimension: base_ad_group_id {
      hidden: yes
      sql: ${TABLE}.BaseAdGroupId ;;
    }
    dimension: keyword_primary_key {
      hidden: yes
      sql: concat(${ad_group_primary_key}, "|", ${criterion_id_string}, "|", ${slot}) ;;
    }
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
      sql: ${TABLE}.CriterionId ;;
    }
    dimension: criterion_type {
      hidden: yes
      sql: ${TABLE}.CriterionType ;;
    }
    dimension: creative_id {
      hidden: yes
      sql: ${TABLE}.CreativeId ;;
    }
    dimension: creative_id_string {
      hidden: yes
      sql: CAST(${TABLE}.CreativeId as STRING) ;;
    }
    dimension: is_negative {
      hidden: yes
      type: yesno
      sql: ${TABLE}.IsNegative ;;
    }
    dimension: is_negative_string {
      hidden: yes
      sql: CAST(${TABLE}.IsNegative AS STRING) ;;
    }
    dimension: interactions {
      hidden: yes
      type: number
      sql: ${TABLE}.Interactions ;;
    }
    dimension: average_position {
      hidden: yes
      type: number
      sql:0;;
    }
    dimension: clicks {
      hidden: yes
      type: number
      sql: ${TABLE}.Clicks;;
    }
    dimension: conversions {
      hidden: yes
      type: number
      sql: ${TABLE}.Conversions ;;
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
    dimension: impressions {
      hidden: yes
      type: number
      sql: ${TABLE}.Impressions ;;
    }
    dimension: click_rate {
      hidden: yes
      label: "Click Through Rate"
      description: "Percent of people that click on an ad."
      type: number
      sql: ${clicks}*1.0/nullif(${impressions},0) ;;
      value_format_name: percent_2
    }
    dimension: cost_per_conversion {
      hidden: yes
      label: "Cost per Conversion"
      description: "Cost per conversion."
      type: number
      sql: ${cost}*1.0 / NULLIF(${conversions},0) ;;
      value_format_name: usd
    }
    dimension: value_per_conversion {
      hidden: yes
      label: "Value per Conversion"
      description: "Conv. Value per conversion."
      type: number
      sql: ${conversionvalue}*1.0 / NULLIF(${conversions},0) ;;
      value_format_name: usd
    }
    dimension: cost_per_click {
      hidden: yes
      label: "Cost per Click"
      description: "Average cost per ad click."
      type: number
      sql: ${cost}*1.0 / NULLIF(${clicks},0) ;;
      value_format_name: usd
    }
    dimension: value_per_click {
      hidden: yes
      label: "Value per Click"
      description: "Conv. Value per Click."
      type: number
      sql: ${conversionvalue}*1.0 / NULLIF(${clicks},0) ;;
      value_format_name: usd
    }
    dimension: cost_per_impression {
      hidden: yes
      label: "CPM"
      description: "Average cost per 1000 ad impressions."
      type: number
      sql: ${cost}*1.0 / NULLIF(${impressions},0) * 1000.0 ;;
      value_format_name: usd
    }
    dimension: value_per_impression {
      hidden: yes
      label: "Value per Impression"
      description: "Conv. Value per Impression."
      type: number
      sql: ${conversionvalue}*1.0 / NULLIF(${impressions},0) ;;
      value_format_name: usd
    }
    dimension: value_per_cost {
      hidden: yes
      label: "ROAS"
      description: "Return on Ad Spend."
      type: number
      sql: ${conversionvalue}*1.0 / NULLIF(${cost},0) ;;
      value_format_name: percent_0
    }
    dimension: conversion_rate {
      hidden: yes
      label: "Conversion Rate"
      description: "Percent of people that convert after they interact with an ad."
      type: number
      sql: ${conversions}*1.0 / NULLIF(${clicks},0) ;;
      value_format_name: percent_2
    }



  }
