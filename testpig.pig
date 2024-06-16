file = LOAD '/user/mugilmithran/customer_purchases.csv' USING PigStorage(',') AS
(customer_id: int, purchase_date: chararray, product_id: int, product_name: chararray, quantity: int, total_amount: float);

grouped_customer_id = GROUP file BY customer_id;

total_amount = FOREACH grouped_customer_id GENERATE group AS customer_id, SUM(file.total_amount) AS total_amount;

DUMP total_amount;
