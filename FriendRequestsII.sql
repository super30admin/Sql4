'''
4 Problem 4 : Friend Requests II (https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/ )
'''

WITH CTE AS (
    SELECT requester_id AS id
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id
    FROM RequestAccepted )

SELECT id, COUNT(id) AS num
FROM CTE
GROUP BY id
ORDER BY num DESC  
LIMIT 1