SELECT mode(score), mode(zip) 
FROM inspections
LEFT JOIN  zipcodepop ON inspections.zip = zipcodepop.zipcode
GROUP BY score



