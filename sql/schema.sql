CREATE DATABASE IF NOT EXISTS support_ops;
USE support_ops;

CREATE TABLE IF NOT EXISTS departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS assets (
    asset_id INT AUTO_INCREMENT PRIMARY KEY,
    hostname VARCHAR(120) NOT NULL UNIQUE,
    asset_type VARCHAR(80) NOT NULL,
    environment VARCHAR(40) NOT NULL DEFAULT 'Lab',
    owner_department_id INT,
    status ENUM('Active', 'Maintenance', 'Retired') NOT NULL DEFAULT 'Active',
    CONSTRAINT fk_assets_department
        FOREIGN KEY (owner_department_id) REFERENCES departments(department_id)
);

CREATE TABLE IF NOT EXISTS tickets (
    ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_number VARCHAR(30) NOT NULL UNIQUE,
    title VARCHAR(180) NOT NULL,
    description TEXT,
    priority ENUM('Low', 'Medium', 'High', 'Critical') NOT NULL DEFAULT 'Medium',
    status ENUM('Open', 'In Progress', 'Pending', 'Closed') NOT NULL DEFAULT 'Open',
    category VARCHAR(80) NOT NULL,
    asset_id INT,
    assigned_department_id INT,
    opened_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    closed_at DATETIME NULL,
    CONSTRAINT fk_tickets_asset
        FOREIGN KEY (asset_id) REFERENCES assets(asset_id),
    CONSTRAINT fk_tickets_department
        FOREIGN KEY (assigned_department_id) REFERENCES departments(department_id)
);

CREATE INDEX idx_tickets_status_priority ON tickets(status, priority);
CREATE INDEX idx_tickets_opened_at ON tickets(opened_at);
