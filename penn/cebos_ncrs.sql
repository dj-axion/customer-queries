SELECT
	ncr.NonconformanceNumber_f as "Non-conformance Number",
	ncr.InitiatedDate_f as "Initiated Date",
	ncr.ProblemDescription_f as "Problem Description",
	st.Name as "Current State",
	ps.DisplayExpression_f as "Problem Symptom",
	IIF(ncr.EscalatetoSCAR_f = 1, 'TRUE', 'FALSE') as "Escalate to SCAR",
    initby.DisplayExpression_f as "Initiated By",
    champ.DisplayExpression_f as Champion,
    ncat.Category_f as Category,--Category
    item.DisplayExpression_f as "Failed Item",--Failed Item
    cust.DisplayExpression_f as Customer,--Customer
    site.DisplayExpression_f as Site,--Site
    rsite.DisplayExpression_f as "Responsible Site",--Responsible Site
    psrc.DisplayExpression_f as "Problem Source",--Problem Source
    supp.DisplayExpression_f as Supplier,--Supplier
	pdis.DisplayExpression_f as "Problem Disposition",--Problem Diposition
	ncr.DispositionNotes_f as "Disposition Notes",--Disposition Notes
	psev.DisplayExpression_f as "Problem Severity",--Problem Severity
	psev.SeverityCriteria_f as "Severity Criteria",--Problem Severity Critieria met
	ncr.ItemCost_f * ncr.Quantity_f as "Derived Cost",
	ncr.InitialMaterialCost_f as "Initial Material Cost",--cost
	xp.MachineType_xf as "Machine Type",--machine
	prcs.DisplayExpression_f as Process,--process
	--ncr.EscapeRootCause_f as "Escape Root Cause",--escaperootcause - code
	ncr.EscapeCauseNotes_f as "Escape Cause Notes",--escapecausenotes
	ncr.EscapeCAPlan_f as "Escape CA Plan",--escapecorrectiveaction
	--ncr.OccurrenceRootCause_f as "Occurrence Root Cause",--occurrencerootcause - code
	ncr.OccurrenceCauseNotes_f as "Occurrence Cause Notes",--occurrencecausenotes
	ncr.OccurrenceCAPlan_f as "Occurrence CA Plan", --occurrencecorrectiveaction
	--ncr.SystemicRootCause_f as "Systemic Root Cause",--Systemicrootcause - code
	ncr.SystemicCauseNotes_f as "Systemic Cause Notes",--Systemiccausenotes
	ncr.SystemicCAPlan_f as "Systemic CA Plan" --Systemiccorrectiveaction
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
LEFT JOIN NonconformancesCategory_p as ncat
	ON ncr.Category_f = ncat.Id
LEFT JOIN ProblemCategory_p as psrc
	ON ncr.ProblemCategory_f = psrc.Id
LEFT JOIN Items_p as item
	ON ncr.FailedItem_f = item.Id
LEFT JOIN Companies_p as cust
	ON ncr.Customer_f = cust.Id
LEFT JOIN ProblemDispositions_p as pdis
	ON ncr.ProblemDisposition_f = pdis.Id
LEFT JOIN ProblemSeverities_p as psev
	ON ncr.ProblemSeverity_f = psev.Id
LEFT JOIN Processes_p as prcs
	ON ncr.Process_f = prcs.Id
LEFT JOIN Nonconformances_xp as xp
	ON ncr.Id = xp.Id
WHERE
	ncr.NonconformanceNumber_f <= 28801
	--AND ncr.NonconformanceNumber_f > 30322
	ncr.InitiatedDate_f >= '2022-12-01' --when cleared w/ Paula, change to L30
	AND ncr.Site_f IN (408, 405, 403, 402, 401, 398, 395, 
						393, 390, 389, 388, 386, 384, 382, 
						379, 378, 377, 371, 367, 364, 362)
ORDER BY ncr.NonconformanceNumber_f DESC