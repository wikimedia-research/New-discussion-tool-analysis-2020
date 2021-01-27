
SELECT 
  CONCAT(year, '-', LPAD(month, 2, '0'), '-', LPAD(day, 2, '0')) as date,
  wiki AS wiki,
  event.platform,
  event.init_type as init_type,
  COUNT(*) as n_events
FROM event.editattemptstep
WHERE
  event.action = 'init'
  AND event.integration = 'discussiontools'
  AND year = 2021
  AND dt >= '2021-01-01'
GROUP BY
  CONCAT(year, '-', LPAD(month, 2, '0'), '-', LPAD(day, 2, '0'))
  wiki,
  event.platform,
  event.init_type
