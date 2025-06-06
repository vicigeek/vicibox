SELECT 
    table_schema AS `Database`, 
    table_name AS `Table`, 
    ROUND((data_length + index_length) / 1024 / 1024, 2) AS `Size_MB`
FROM information_schema.tables
WHERE table_schema NOT IN ('information_schema', 'mysql', 'performance_schema', 'sys')
ORDER BY `Size_MB` DESC
LIMIT 20;



# delete api logs older than 1 day
DELETE FROM vicidial_api_urls 
WHERE api_date < NOW() - INTERVAL 1 DAY;
