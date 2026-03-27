-- Migration: 008_add_dashboard_config
-- Description: Add dashboard_config JSONB column to users table for admin dashboard preferences
-- Up migration

ALTER TABLE users ADD COLUMN IF NOT EXISTS dashboard_config JSONB DEFAULT '{}'::jsonb;

-- Create index for faster queries on dashboard_config
CREATE INDEX IF NOT EXISTS idx_users_dashboard_config ON users USING GIN (dashboard_config);

-- Add constraint to ensure dashboard_config is valid JSON
ALTER TABLE users ADD CONSTRAINT dashboard_config_valid_json CHECK (dashboard_config IS NOT NULL);
