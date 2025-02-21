CREATE TABLE product_dim (
    product_id VARCHAR(6) PRIMARY KEY CHECK (product_id ~ '^P[A-Z][0-9]{4}$'),
    product_name TEXT NOT NULL,
    category TEXT NOT NULL,
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price > 0)
);

CREATE TABLE customer_dim (
    customer_id VARCHAR(6) PRIMARY KEY CHECK (customer_id ~ '^C[A-Z][0-9]{4}$'),
    customer_name TEXT NOT NULL,
    city TEXT,
    country TEXT,
    membership_num VARCHAR(20) DEFAULT NULL
);

CREATE TABLE store_dim (
    store_id VARCHAR(6) PRIMARY KEY CHECK (store_id ~ '^S[A-Z][0-9]{4}$'),
    store_name TEXT NOT NULL CHECK (LENGTH(store_name) = 6),
    city TEXT NOT NULL,
    country TEXT NOT NULL,
    region TEXT CHECK (region IN ('Oceania', 'Asia', 'Europe', 'North America', 'South America'))
);

CREATE TABLE date_dim (
    date_id SERIAL PRIMARY KEY,
    full_date DATE UNIQUE NOT NULL,
    year INT CHECK (year BETWEEN 1900 AND 2100),
    month INT CHECK (month BETWEEN 1 AND 12),
    day INT CHECK (day BETWEEN 1 AND 31)
);

CREATE TABLE sales_fact (
    sales_id SERIAL PRIMARY KEY,
    date_id INT REFERENCES date_dim(date_id) ON DELETE CASCADE,
    product_id VARCHAR(6) REFERENCES product_dim(product_id) ON DELETE CASCADE,
    customer_id VARCHAR(6) REFERENCES customer_dim(customer_id) ON DELETE CASCADE,
    store_id VARCHAR(6) REFERENCES store_dim(store_id) ON DELETE CASCADE,
    quantity INT NOT NULL CHECK (quantity > 0),
    sales_amount NUMERIC(10,2) NOT NULL CHECK (sales_amount > 0)
);
