Customer Complaints Data Analysis (ReadMe) And Recommendation Document 

This document presents insights generated from analyzing customer complaint data using SQL queries and visualizations built in Power BI via DirectQuery. The analysis is organized by tasks and focuses on generating actionable insights for Both Technical and non-technical stakeholders.

Task 1 Question 1:  Complaint Category and Customer Satisfaction Analysis
Top 2 Complaint Categories by Volume
I analyzed the volume of complaints and identified the top two categories by frequency. These are the most recurring types of issues reported by customers and are key targets for improvement.
From task 1. 
It was observed that the two top complaint categories are 
1.	Exchange rate with total complaint counts of 79. This indicates that 79 complaints are due to the Exchange rate 
2.	Technical Issues with a total complaint count of 78, which indicates that 78 complaints were received because of technical issues

Task 1 Question 2
Average Satisfaction Rating by Complaint Channel
This query shows the average customer satisfaction rating across different complaint channels. It helps identify which channels are performing best from a customer experience perspective.
From Task 2.
It was observed that there are three channels that their an average satisfaction by customers rating and they are 
1.	Phone with average satisfaction rating of 2.98666666666667, this indicates that customers who complained received on phone call rated the company on their satisfaction rate of approximately 3.0 out of 5 stars rating, meaning they seem fairly satisfied with their engagement with the customer service via phone
2.	Chat with an average satisfaction rating of 3.09375, indicating that customers who resolved to complain via chat with the company's virtual assistant received a good satisfaction rate on average.
3.	Email with average satisfaction rating of 3.11111111111111 at approximation of 3.1 indicates that customers who submitted their complaint via email are more satisfied, and they give a higher rating on average basis for their complaint resolution.

Task 1 Question 3
Do High-Priority Complaints Get Resolved Faster?
I compared the average resolution time between high- and low-priority complaints. This helps assess whether high-priority cases are receiving faster attention as expected. 
This query translates resolution times into minutes, hours, and days, making it easier for stakeholders to understand and compare the time taken to resolve high- vs. low-priority issues
From the task query result, 
1.	High Complaint Priority has an average resolution time of 4 days, 9 hours, and 8 minutes
2.	Low Priority Complaint has an average resolution time of 6 days, 20 minutes 
Yes, high-priority complaints are resolved faster — almost 1 day and 1 hour quicker on average.
Task 2 Question 1 :Vulnerable Customer Cases Analysis
Most Frequent Root Cause
This identifies the most common primary root cause for complaints among vulnerable customers, which is crucial for targeted support and prevention.
This query result returns the Most Frequent root cause from our Table, which appears to be 
A Process: Third Party Dependency: Third Party Info Delay with root cause occurrence with 41 complaint incidents 

Task 2 Question 2 : Average Handling Time (in Days and  Hours From Ticket creation to completion)
This calculates the average time taken to resolve a case from the time it was opened to when it was solved. It provides a clear metric for operational efficiency.
From my query, the Average Handling time in days is 15 days, 5 Hours, meaning it took 15 days and 5 hours on an average basis to resolve all customers' complaints from ticket creation till completion.

Task 2 Question 3 
One way Wise could improve the experience for vulnerable customers, based on my findings, is 
Suggestion:
If the most frequent ec_primary_root_cause is related to a process like "Delayed Transaction Confirmation" and the average handling time is more than a day, Wise should implement proactive communication updates (e.g., automated SMS/email updates) and faster triaging for those common root causes.
Why:
•	Reduces anxiety for vulnerable users.
•	Targets the most common pain point with quicker, empathetic resolution

Task 3 : Complaint KPIs Summary and Operational Trends
Task 3 Question 1: Region with Lowest Median Handling Time
This query shows the region with the fastest case handling time, using the median to avoid skew from outliers.
From my Query, Europe is the region with the lowest handling time, with an average response time of 7 minutes from ticket creation to completion  

Task 3 Question 2 Redress Cost Trend Over Last 3 Months
This shows the monthly trend in the total amount spent on complaint redress over the most recent three months. It provides insights into cost management and customer recovery strategies.
This is presented on the table below
Month	Total Redress Cost in GBP
Dec 2024	£92,174
Nov 2024    	£303,258
Oct 2024    	 £177,000


Task 3 Question 3: Correlation of Headcount and Handling Time by Region
I explored whether regions with more operational staff tend to have faster complaint resolution times. This can guide workforce planning and resource allocation. Regions with a higher average Headcount_OPS tend to have lower Median Handling Times, suggesting that increased operational staffing supports quicker complaint resolution. This implies that investing in staffing capacity could directly enhance operational efficiency

Task 3 Question 3 B: QA Pass Rate vs. Redress Cost by Region
This compares the quality assurance pass rate with the average redress cost by region, helping to identify areas where high QA correlates with low customer compensation.
There appears to be a negative correlation between Stage1_QA_Pass_Rate and Complaint_Redress_Cost. Regions with higher QA pass rates generally report lower average redress costs, indicating that better quality assurance at early stages may prevent costly resolutions or escalations later.

Task 3 Question 4: Proposed KPI: "First Contact Resolution Rate (FCR)"
Why this KPI matters:
Tracking the First Contact Resolution Rate—the percentage of complaints resolved during the first customer interaction—can provide Wise with deep insight into both efficiency and customer satisfaction. A high FCR means that issues are being resolved quickly and accurately, without requiring follow-ups, which reduces handling time, lowers redress costs, and improves user trust.
Strategic Impact:
•	It supports quality assurance by measuring effectiveness of front-line resolutions.
•	It contributes to cost reduction, as repeat contacts often lead to longer handling times and potential redress.
•	It highlights training needs where FCR is low, pointing to opportunities for team development.
This KPI complements existing metrics like QA pass rate and redress cost, offering a more customer-centric view of operational performance.

Task 4 Question 2.
Recommendation / Next Step for Wise:
Based on the overall analysis, Wise should prioritize automating status updates and implementing proactive communication for high-frequency complaint categories, particularly for vulnerable customers and third-party delays. By doing this, Wise can:
•	Reduce anxiety for customers waiting on resolutions (especially vulnerable users),
•	Improve satisfaction scores across all complaint channels,
•	Potentially lower complaint volumes and redress costs by setting expectations early and clearly,
•	Free up operational staff to focus on complex, non-routine complaints.
Next Step: Launch a pilot initiative to implement automated, real-time status notifications (via SMS or email) for complaints tagged with the top 2 categories—Exchange Rate and Technical Issues—and assess the impact on resolution times, redress costs, and satisfaction scores after 30 days.

Dax Formula  used 
Redress cost by Month  (MonthOnly) Dax Formula
MonthOnly = 
SWITCH(
    MONTH(Query9[Month]),
    1, "January",
    2, "February",
    3, "March",
    4, "April",
    5, "May",
    6, "June",
    7, "July",
    8, "August",
    9, "September",
    10, "October",
    11, "November",
    12, "December"
)

Root Cause Summary by Occurrence Count DAX formula 
Top Root Cause Summary = 
VAR TopRow =
    TOPN(
        1,
        Query6,
        Query6[Occurrence],
        DESC
    )
RETURN
    CONCATENATEX(
        TopRow,
        Query6[ec_primary_root_cause] & " – " & FORMAT(Query6[Occurrence], "#,##0") & " Cases",
        ", "
    )


