
SELECT 
  wiki AS wiki,
  event.platform
  event.init_type as init_type,
  COUNT(*)
FROM event.editattemptstep
WHERE
  event.action = 'init'
  AND event.integration = 'discussiontools'
  AND year = 2021
  AND dt >= '2021-01-12'
GROUP BY
  wiki,
  event.platform
  event.init_type
