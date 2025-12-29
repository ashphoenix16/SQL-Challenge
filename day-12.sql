-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

WITH most_active
  AS
  (
SELECT u.user_id,DATE(m.sent_at) AS sent_date,COUNT(message_id) AS msg_count,
    DENSE_RANK() OVER(PARTITION BY DATE(m.sent_at) ORDER BY COUNT(message_id) DESC) AS active_rnk
    FROM npn_users u
JOIN npn_messages m
ON u.user_id = m.sender_id
GROUP BY u.user_id,DATE(m.sent_at)
  )
  SELECT user_id,sent_date,msg_count
  FROM most_active
  WHERE active_rnk = 1
;
