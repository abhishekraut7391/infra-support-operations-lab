USE support_ops;

-- 1. View all tickets, newest first.
SELECT ticket_number, title, priority, status, category, opened_at
FROM tickets
ORDER BY opened_at DESC;

-- 2. Find high and critical tickets that are not closed.
SELECT ticket_number, title, priority, status
FROM tickets
WHERE priority IN ('High', 'Critical')
  AND status <> 'Closed'
ORDER BY priority, opened_at;

-- 3. Count tickets by status.
SELECT status, COUNT(*) AS ticket_count
FROM tickets
GROUP BY status
ORDER BY ticket_count DESC;

-- 4. Join tickets with their assigned department.
SELECT t.ticket_number, t.title, t.status, d.department_name
FROM tickets AS t
LEFT JOIN departments AS d
  ON t.assigned_department_id = d.department_id
ORDER BY t.opened_at DESC;

-- 5. Count tickets by category.
SELECT category, COUNT(*) AS ticket_count
FROM tickets
GROUP BY category
ORDER BY ticket_count DESC;

-- 6. Show assets and owning departments.
SELECT a.hostname, a.asset_type, a.environment, d.department_name
FROM assets AS a
LEFT JOIN departments AS d
  ON a.owner_department_id = d.department_id
ORDER BY a.hostname;
