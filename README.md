# businessinspectionscores
# Overview
In this capstone project, we are analyzing business inspection data alongside U.S Census Davidson County, TN data to conduct a comprehensive analysis of food safety and public health in Davidson County, TN. By examining the intersection of these two datasets, our goal is to uncover insights into the relationship between demographic factors and restaurant cleanliness, providing valuable information for public health officials, restaurant owners, and community stakeholders.


# Research Questions

1. Is there any significance in estalishment location and inspection scores?
2. Do restaurant inspection scores correlate with demographic factors such as education level in the surrounding area? 
3. How do restaurant inspection scores correlate with demographic factors such as income levels in the surrounding neighborhoods?
	• Are there any trends indicating that businesses in areas where there are a high number of households that make more than $60k tend to have better average inspection scores?

	• What about lower income households? Are there any trends indicating that businesses in areas where there are a high number of households that make LESS than $59k tend to have better or worse average inspection scores? 
					
4. How does the racial or ethnic composition of a neighborhood relate to restaurant inspection scores?
	• Are there disparities in inspection scores based on the racial or ethnic makeup of the surrounding population?

5. Are there any trends indicating that their is a relationship between residents' ages and inspection score averages in a specific zip code? Do restaurants located in areas with older or younger populations tend to have different or similar inspection outcomes?
# Dataset Sources

Restaurant inspections dataset (webscraped):
https://inspections.myhealthdepartment.com/tennessee 
Zip Code data for Davidson County, TN:
 https://censusreporter.org/profiles/05000US47037-davidson-county-tn/

# Methodology
Both Python and PgAdmin (SQL) were heavily used to clean the datasets during the analysis.

# Findings
With this observation, we can indicate that areas with households with high incomes does not necessarily indicate better inspection scores ratings. 

With this observation, we can indicate that areas that have a high amount of households with lower incomes does not relate to lower inspection score ratings.

With this observation, we can indicate that their no direct relationship between the number of minority population and white population compared to the average inspection scores and it's location.

With this observation, we can indicate that their is not signficant relationship in the business location and the average inspection score in that location due to all of the inspection scores being around the same percentage. 

# Limitations
 Census Data did not provide any demographic information for 7 zipcodes. 2 zipcodes from the Inspections data was were outside of the state of Tennessee. 
# Dashboard Presentation
The final dashboard can be viewed in the link below:
https://app.powerbi.com/view?r=eyJrIjoiMDY0N2ExZGQtNjYwMy00ZWFiLTk4NjctNThmZGMzOTA1ZmQzIiwidCI6IjEwMWRhNTg3LTE4NDMtNGY1Mi04YjhhLTE3YjA2OWM2NmQzMyIsImMiOjJ9&pageName=ReportSectionc04c411248d7dbd1cd1d