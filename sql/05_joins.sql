-- INNER JOIN >> Show users and their predictions
SELECT
    u.full_name,
    p.prediction,
    p.confidence
FROM predictions AS p
INNER JOIN users AS u ON p.user_id = u.id;


-- LEFT JOIN >> Show all users and their predictions
SELECT
    u.full_name,
    p.prediction,
    p.confidence
FROM users AS u
LEFT JOIN predictions AS p ON u.id = p.user_id;


-- RIGHT JOIN >>  Show all predictions and related users
SELECT
    u.full_name,
    p.prediction,
    p.confidence
FROM users AS u
RIGHT JOIN predictions AS p ON u.id = p.user_id;


-- FULL JOIN >> Show all users and all predictions
SELECT
    u.full_name,
    p.prediction,
    p.confidence
FROM users AS u
FULL JOIN predictions AS p ON u.id = p.user_id;


-- Multiple Table JOIN >> Prediction Report
SELECT
    u.full_name AS user_name,
    m.model_name,
    d.filename,
    p.prediction,
    p.confidence,
    p.created_at
FROM predictions AS p
INNER JOIN users AS u ON p.user_id = u.id
INNER JOIN ml_models AS m ON p.model_id = m.id
INNER JOIN datasets AS d ON p.dataset_id = d.id
ORDER BY p.created_at DESC;


-- INNER JOIN + WHERE
SELECT
    u.full_name,
    p.prediction,
    p.confidence
FROM predictions AS p
INNER JOIN users AS u ON p.user_id = u.id
WHERE p.prediction = 'Spam';


--INNER JOIN + GROUP BY + COUNT()
SELECT
    u.full_name,
    COUNT(p.id) AS total_predictions
FROM users AS u
INNER JOIN predictions AS p ON u.id = p.user_id
GROUP BY u.full_name;


--INNER JOIN + GROUP BY + HAVING
SELECT
    u.full_name,
    COUNT(p.id) AS total_predictions
FROM users AS u
INNER JOIN predictions AS p ON u.id = p.user_id
GROUP BY u.full_name
HAVING COUNT(p.id) > 1;


--Multiple Table JOIN + WHERE + GROUP BY + HAVING
SELECT
    m.model_name,
    COUNT(p.id) AS total_predictions,
    AVG(p.confidence) AS avg_confidence,
    MAX(p.confidence) AS highest_confidence
FROM predictions AS p
JOIN ml_models AS m ON p.model_id = m.id
JOIN datasets AS d ON p.dataset_id = d.id
WHERE d.file_size > 2000
GROUP BY m.model_name
HAVING COUNT(p.id) >= 1
ORDER BY avg_confidence DESC;


--Average Confidence
SELECT
    m.model_name,
AVG(p.confidence)
FROM predictions AS p
JOIN ml_models AS m ON p.model_id=m.id
GROUP BY m.model_name;


--Highest Confidence
SELECT
    m.model_name,
MAX(p.confidence)
FROM predictions AS p
JOIN ml_models AS m ON p.model_id=m.id
GROUP BY m.model_name;


--Lowest Confidence
SELECT
m.model_name,
MIN(p.confidence)
FROM predictions AS p
JOIN ml_models AS m ON p.model_id=m.id
GROUP BY m.model_name;


SELECT
m.model_name,
COUNT(*) AS total_predictions,
AVG(p.confidence) AS avg_confidence,
MAX(p.confidence) AS highest_confidence,
MIN(p.confidence) AS lowest_confidence
FROM predictions AS p
JOIN ml_models AS m ON p.model_id=m.id
GROUP BY m.model_name
HAVING COUNT(*)>=1
ORDER BY avg_confidence DESC;