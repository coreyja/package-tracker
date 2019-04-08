SELECT DISTINCT ON (package_id) *
FROM tracking_updates
ORDER BY package_id, tracking_updated_at DESC
