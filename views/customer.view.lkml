include: "base/google_adwords_base.view"
include: "adwords_config.view"

view: customer {
  extends: [account_table_name_base, google_adwords_base, adwords_config]
  sql_table_name:
  (
    SELECT account.*
    FROM {{ customer.adwords_schema._sql }}.{{ customer.account_table_name._sql }} as account
    INNER JOIN (
    SELECT
      date,
      customer_id,
      MAX(_fivetran_id) as max_fivetran_id
    FROM {{ customer.adwords_schema._sql }}.{{ customer.account_table_name._sql }} GROUP BY 1,2) AS max_account
    ON account._fivetran_id = max_account.max_fivetran_id
    AND account.date = max_account.date
    AND account.customer_id = max_account.customer_id
  ) ;;

    dimension: account_currency_code {
      hidden: yes
      type: string
      sql: ${TABLE}.account_currency_code ;;
    }

    dimension: account_descriptive_name {
      type: string
      sql: ${TABLE}.account_descriptive_name ;;
#     required_fields: [external_customer_id]
    }

    dimension: account_time_zone {
      hidden: yes
      type: string
      sql: ${TABLE}.account_time_zone ;;
    }

    dimension: customer_descriptive_name {
      hidden: yes
      type: string
      sql: ${TABLE}.customer_descriptive_name ;;
    }
}

view: account_table_name_base {
  extension: required
  dimension: account_table_name {
    hidden: yes
    sql:account;;
  }
}
