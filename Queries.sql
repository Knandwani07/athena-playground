title: "Analyze CloudFront Logs"
description: "Create DB, external table, and analyze logs by browser"
content: |
  ```sql
  -- ============================================
  -- 🛠️  Step 1: Create a New Database
  -- ============================================

  CREATE DATABASE mydatabase;

  -- ============================================
  -- 🗃️  Step 2: Create External Table for CloudFront Logs
  -- ============================================

  CREATE EXTERNAL TABLE IF NOT EXISTS cloudfront_logs (
    `Date` DATE,
    Time STRING,
    Location STRING,
    Bytes INT,
    RequestIP STRING,
    Method STRING,
    Host STRING,
    Uri STRING,
    Status INT,
    Referrer STRING,
    ClientInfo STRING
  )
  ROW FORMAT DELIMITED
  FIELDS TERMINATED BY '\t'
  LINES TERMINATED BY '\n'
  LOCATION 's3://athena-examples-ap-south-1/cloudfront/plaintext/';

  -- ============================================
  -- 📊 Step 3: Analyze Requests by Browser Type
  -- ============================================

  SELECT 
    CASE 
      WHEN ClientInfo LIKE '%IE/%' THEN 'Internet Explorer'
      WHEN ClientInfo LIKE '%Chrome/%' THEN 'Chrome'
      WHEN ClientInfo LIKE '%Firefox/%' THEN 'Firefox'
      WHEN ClientInfo LIKE '%Safari/%' THEN 'Safari'
      WHEN ClientInfo LIKE '%Opera/%' THEN 'Opera'
      ELSE 'Other'
    END AS Browser,
    COUNT(*) AS RequestCount,
    SUM(Bytes) AS TotalBytes
  FROM cloudfront_logs 
  WHERE date BETWEEN date '2014-07-05' AND date '2014-08-05' 
  GROUP BY 
    CASE 
      WHEN ClientInfo LIKE '%IE/%' THEN 'Internet Explorer'
      WHEN ClientInfo LIKE '%Chrome/%' THEN 'Chrome'
      WHEN ClientInfo LIKE '%Firefox/%' THEN 'Firefox'
      WHEN ClientInfo LIKE '%Safari/%' THEN 'Safari'
      WHEN ClientInfo LIKE '%Opera/%' THEN 'Opera'
      ELSE 'Other'
    END
  ORDER BY RequestCount DESC;
