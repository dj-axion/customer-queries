"""
SQL to pull customer data from the CEBOS databases
Accessible from AWS workspaces
SSMS -> 172.16.123.18
    -> Databases
        -> EQMSRT
            -> New Query
stored for posterity (doesn't work standalone)
watch the double-underscores __
"""

SELECT
	ncr.NonconformanceNumber_f as "Non-conformance Number",
	ncr.InitiatedDate_f as "Initiated Date",
	ncr.ProblemDescription_f as "Problem Description",
	st.Name as "Current State",
	ps.DisplayExpression_f as "Problem Symptom",
	IIF(ncr.EscalatetoSCAR_f = 1, 'TRUE', 'FALSE') as "Escalate to SCAR",
    ,--Initiated By
    ,--Champion
    ,--Category
    ,--Failed Item
    ,--Customer
    ,--Site
    ,--Responsible Site
    ,--Problem Source
    ,--Supplier
	ncr.*
FROM
	Nonconformances_p as ncr
LEFT JOIN __State as st
	ON ncr.CurrentState = st.Id
LEFT JOIN ProblemSymptoms_p as ps
	ON ncr.ProblemSymptom_f = ps.Id
--Champion_f
--InitiatedBy_f
--Site_f
--ProblemCategory_f
--CustomerPartNumber_f or FailedItem_f

WHERE
	InitiatedDate_f > '2023-01-01'
