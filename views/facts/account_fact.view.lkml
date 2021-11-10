include: "/views/base/*.view"

view: account_key_base {
  extends: [date_primary_key_base]
  extension: required

  dimension: account_key_base {
    hidden: yes
    sql:
      {% if _dialect._name == 'snowflake' %}
        TO_CHAR(${external_customer_id})
      {% elsif _dialect._name == 'redshift' %}
        CAST(${external_customer_id} AS VARCHAR)
      {% else %}
        CAST(${external_customer_id} AS STRING)
      {% endif %} ;;
  }
  dimension: key_base {
    hidden: yes
    sql: ${account_key_base} ;;
  }
}

view: account_date_fact {
  extends: [date_base, google_ad_metrics_base, account_key_base, period_base, ad_metrics_period_comparison_base, ad_metrics_weighted_period_comparison_base]

  derived_table: {
    datagroup_trigger: adwords_etl_datagroup
    explore_source: ad_impressions {
      column: _date { field: fact.date_date }
      column: external_customer_id { field: fact.external_customer_id }
      column: clicks {field: fact.total_clicks }
      column: conversions {field: fact.total_conversions}
      column: conversionvalue {field: fact.total_conversionvalue}
      column: cost {field: fact.total_cost}
      column: impressions { field: fact.total_impressions}
      column: interactions {field: fact.total_interactions}
    }
  }
  dimension: external_customer_id {
    hidden: yes
  }
  dimension: _date {
    hidden: yes
    type: date_raw
    sql:
      {% if _dialect._name == 'snowflake' %}
        TO_DATE(${TABLE}._date)
      {% else %}
        CAST(${TABLE}._date AS DATE)
      {% endif %} ;;
  }
  set: detail {
    fields: [external_customer_id]
  }
}
