file = LOAD '/user/mugilmithran/customer_purchases.csv' USING PigStorage(',') AS
(customer_id: int, purchase_date: chararray, product_id: int, product_name: chararray, quantity: int, total_amount: float);

grouped_customer_id = GROUP file BY customer_id;

total_amount = FOREACH grouped_customer_id GENERATE group AS customer_id, SUM(file.total_amount) AS total_amount;

highest_quantity = GROUP file BY (product_id, product_name);

highest_quantity_purchased = FOREACH highest_quantity GENERATE FLATTEN(group) AS (product_id, product_name), SUM(file.quantity) AS total_num;

highest_qty_purchased = ORDER highest_quantity_purchased BY total_num DESC; 

highest_num_purchased = LIMIT highest_quantity_purchased 1;

grouped_avg_purchase = GROUP file BY customer_id;

avg_purchase = FOREACH grouped_avg_purchase GENERATE group AS customer_id, AVG(file.total_amount) AS avg_amount;

avg_pur = ORDER avg_purchase BY avg_amount DESC;

high_value_cus = FILTER file BY total_amount > 100;

cust_purchase = FOREACH grouped_customers GENERATE group AS customer_id, COUNT(file.quantity) AS pur_count;

highest_purchase_frequency = ORDER cust_purchase BY pur_count DESC;
