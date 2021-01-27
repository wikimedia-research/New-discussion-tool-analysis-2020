WITH init_sessions AS (
SELECT 
  event.editing_session_id AS session_id,
  IF(event.init_type = 'section', 'new discussion tool', 'reply tool') as dt_type,
  wiki AS wiki
FROM event.editattemptstep
WHERE
  year = 2021 
  AND dt >= '2021-01-12'  -- when instrumetation was deployed
  AND event.action = 'init'
  AND event.integration= 'discussiontools'
)
SELECT
user,
wiki,
min(edit_count) AS edit_count,
COUNT(*) AS completed_edits
FROM (
SELECT
  eas.event.user_editcount AS edit_count,
  eas.event.user_id AS user,
  eas.event.editing_session_id AS session_id,
  eas.wiki AS wiki,
  COUNT(*) AS events
FROM event.editattemptstep eas
INNER JOIN
    init_sessions 
    ON eas.event.editing_session_id = init_sessions.session_id 
    AND eas.wiki = init_sessions.wiki
WHERE
  year = 2021 
-- events since deployment date
  AND dt >= '2021-01-12'
  AND eas.event.action = 'saveSuccess'
  AND eas.event.integration= 'discussiontools'
-- remove anonymous users
  AND eas.event.user_id != 0
GROUP BY 
  eas.event.user_id,
  eas.event.user_editcount,
  eas.event.editing_session_id,
  eas.wiki
) AS sessions_data
GROUP BY
user,
wiki