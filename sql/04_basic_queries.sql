SELECT
    id,
    full_name,
    email
FROM users;

--WHERE
SELECT
    id,
    full_name,
    email
FROM users
WHERE email = 'aung@example.com';

--AND
SELECT
    model_name,
    accuracy
FROM ml_models
WHERE accuracy > 95
AND version = '1.0';

--OR
SELECT
    model_name,
    version
FROM ml_models
WHERE version = '1.0'
OR version = '1.5';

--ORDER BY
SELECT
    model_name,
    accuracy
FROM ml_models
ORDER BY accuracy DESC;
SELECT
    model_name,
    accuracy
FROM ml_models
ORDER BY accuracy ASC;

--LIMIT
SELECT
    model_name,
    accuracy
FROM ml_models
ORDER BY accuracy DESC
LIMIT 3;

--DISTINCT
SELECT DISTINCT
    version
FROM ml_models;

--ALIAS
SELECT
    full_name AS user_name,
    email AS email_address
FROM users;

--LIKE
SELECT
    full_name,
    email
FROM users
WHERE email LIKE '%example.com';

--BETWEEN
SELECT
    model_name,
    accuracy
FROM ml_models
WHERE accuracy BETWEEN 95 AND 99;

--IN
SELECT
    model_name,
    version
FROM ml_models
WHERE version IN ('1.0', '2.1');

--rediction Confidence 0.90
SELECT
    prediction,
    confidence
FROM predictions
WHERE confidence > 0.90
ORDER BY confidence DESC;

