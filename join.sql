SELECT 
    p.product_name,
    p.category,
    SUM(s.sales_amount) AS total_sales,
    SUM(s.quantity) AS total_quantity
FROM sales_fact s
JOIN product_dim p ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sales DESC
LIMIT 10;