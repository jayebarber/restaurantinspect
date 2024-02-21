SELECT score, zip
FROM inspections 
GROUP BY score, zip
ORDER BY score DESC;
