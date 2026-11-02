USE support_ops;

INSERT INTO departments (department_name)
VALUES
  ('IT Support'),
  ('Infrastructure'),
  ('Applications');

INSERT INTO assets (hostname, asset_type, environment, owner_department_id, status)
VALUES
  ('lab-web-01', 'Linux server', 'Lab', 2, 'Active'),
  ('lab-db-01', 'Database server', 'Lab', 2, 'Active'),
  ('lab-app-01', 'Application server', 'Lab', 3, 'Active'),
  ('lab-laptop-01', 'Laptop', 'Lab', 1, 'Active');

INSERT INTO tickets
  (ticket_number, title, description, priority, status, category, asset_id, assigned_department_id, opened_at)
VALUES
  ('LAB-1001', 'Unable to connect to application', 'Fictional application access issue for testing.', 'High', 'Open', 'Application', 3, 3, '2026-11-02 09:00:00'),
  ('LAB-1002', 'Disk usage warning', 'Fictional disk usage alert on lab web server.', 'Medium', 'In Progress', 'Linux', 1, 2, '2026-11-02 09:15:00'),
  ('LAB-1003', 'Database connection retries', 'Fictional application-to-database connectivity symptom.', 'High', 'Open', 'Database', 2, 2, '2026-11-02 09:20:00'),
  ('LAB-1004', 'Laptop software request', 'Fictional software installation request.', 'Low', 'Closed', 'End User', 4, 1, '2026-11-01 14:30:00');
