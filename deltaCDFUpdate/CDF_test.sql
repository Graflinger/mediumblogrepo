-- Databricks notebook source
CREATE OR REPLACE TABLE cdf_test(
  id INT
  ,test STRING
  ,test2 STRING)
  TBLPROPERTIES (
   delta.enableChangeDataFeed = true,
   delta.columnMapping.mode = 'name',
   delta.minReaderVersion = 2,
   delta.minWriterVersion = 5)

-- COMMAND ----------

INSERT INTO cdf_test(id, test, test2) VALUES(1, 'test', 'test2')

-- COMMAND ----------

SELECT 
  *
FROM
  table_changes('cdf_test', 0)

-- COMMAND ----------

ALTER TABLE cdf_test DROP COLUMN test2

-- COMMAND ----------

INSERT INTO cdf_test(id, test) VALUES(2, 'test')

-- COMMAND ----------

SELECT 
  *
FROM
  table_changes('cdf_test', 3)

-- COMMAND ----------

SELECT 
  *
FROM
  table_changes('cdf_test', 0)

-- COMMAND ----------

DESCRIBE HISTORY cdf_test

-- COMMAND ----------

SELECT 
  *
FROM
  table_changes('cdf_test', 0, 3)
