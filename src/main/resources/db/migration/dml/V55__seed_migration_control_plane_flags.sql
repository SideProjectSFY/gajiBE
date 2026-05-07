INSERT INTO system_settings (key, value, description)
VALUES
    ('ff.ai.direct.enabled', 'false', 'Enable direct AI path canary routing'),
    ('ff.ai.direct.kill_switch', 'false', 'Emergency kill switch to force legacy AI path'),
    ('ff.ai.direct.percent', '0', 'Direct AI traffic percentage (0-100)'),
    ('ff.nextjs.route.catalog', 'false', 'Route catalog journey to Next.js'),
    ('ff.nextjs.route.scenario', 'false', 'Route scenario journey to Next.js'),
    ('ff.nextjs.route.conversation', 'false', 'Route conversation journey to Next.js'),
    ('ff.nextjs.route.social', 'false', 'Route social journey to Next.js'),
    ('ff.nextjs.route.search', 'false', 'Route search journey to Next.js'),
    ('kpi.migration.ai.cost.usd_per_1k_requests', '0.0', 'AI migration cost baseline (USD per 1k requests)'),
    ('kpi.migration.nextjs.lcp.parity_ratio', '1.0', 'Next.js LCP parity ratio vs legacy (lower is better)')
ON CONFLICT (key) DO NOTHING;
