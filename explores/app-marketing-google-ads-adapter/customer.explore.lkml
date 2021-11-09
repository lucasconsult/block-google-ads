include: "/views/*.view"
include: "/explores/**/*.explore"

explore: customer_join {
  extension: required

  join: customer {
    from: customer
    view_label: "Customer"
    sql_on: ${fact.external_customer_id} = ${customer.external_customer_id} AND
      ${fact._date} = ${customer._date} ;;
    relationship: many_to_one
  }
}

explore: customer {
  persist_with: adwords_etl_datagroup
  from: customer
  view_name: customer
  hidden: yes
}
