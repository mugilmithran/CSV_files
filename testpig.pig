grouped_customer_id = GROUP file BY customer_id;

total_amount = FOREACH grouped_customer_id GENERATE group AS customer_id, SUM(file.total_amount) AS total_amount;