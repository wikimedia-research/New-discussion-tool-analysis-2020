
SELECT 
  CONCAT(year, '-', LPAD(month, 2, '0'), '-', LPAD(day, 2, '0')) as date,
  wiki AS wiki,
  event.platform as platform,
  event.editor_interface as interface,
  event.integration as integration,
  IF(event.init_type = 'section', 'new discussion tool', 'reply tool') as tool_type
  COUNT(*) as n_events
FROM event.editattemptstep
WHERE
  event.action = 'init'
  AND event.integration = 'discussiontools'
  AND year = 2021
  AND dt >= '2021-01-01'
GROUP BY
  CONCAT(year, '-', LPAD(month, 2, '0'), '-', LPAD(day, 2, '0')),
  wiki,
  event.platform,
  event.editor_interface,
  event.integration,
  event.init_type
