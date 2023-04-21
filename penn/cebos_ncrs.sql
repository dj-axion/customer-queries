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
    initby.DisplayExpression_f as "Initiated By",
    champ.DisplayExpression_f as Champion,
    psrc.DisplayExpression_f as Category,--Category
    item.DisplayExpression_f as "Failed Item",--Failed Item
    cust.DisplayExpression_f as Customer,--Customer
    site.SiteName_f as Site,--Site
    rsite.SiteName_f as "Responsible Site",--Responsible Site
    psrc.DisplayExpression_f as "Problem Source",--Problem Source
    supp.DisplayExpression_f as Supplier--Supplier
FROM
	Nonconformances_p as ncr
LEFT JOIN __State as st
	ON ncr.CurrentState = st.Id
LEFT JOIN ProblemSymptoms_p as ps
	ON ncr.ProblemSymptom_f = ps.Id
LEFT JOIN Employees_p as champ
	ON ncr.Champion_f = champ.Id
LEFT JOIN Employees_p as initby
	ON ncr.InitiatedBy_f = initby.Id
LEFT JOIN Sites_p as site
	ON ncr.Site_f = site.Id
LEFT JOIN Sites_p as rsite
	ON ncr.ResponsibleSite_f = rsite.Id
LEFT JOIN Companies_p as supp
	ON ncr.Supplier_f = supp.Id
LEFT JOIN ProblemCategory_p as psrc
	ON ncr.ProblemCategory_f = psrc.Id
LEFT JOIN Items_p as item
	ON ncr.FailedItem_f = item.Id
LEFT JOIN Companies_p as cust
	ON ncr.Customer_f = cust.Id
WHERE
	ncr.InitiatedDate_f >= '2020-01-01'
	AND ncr.Site_f IN (408, 405, 403, 402, 401, 400, 398, 396, 395, 
						393, 390, 389, 388, 386, 384, 382, 381, 380, 
						379, 378, 377, 371, 370, 369, 367, 364, 362)