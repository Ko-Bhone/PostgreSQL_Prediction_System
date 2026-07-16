--Highest Accuracy Model
SELECT
    model_name,
    accuracy
FROM ml_models
WHERE accuracy = (SELECT MAX(accuracy) FROM ml_models);


--Average Accuracy ထက် မြင့်တဲ့ Model
SELECT
    model_name,
    accuracy
FROM ml_models
WHERE accuracy > (SELECT AVG(accuracy) FROM ml_models);


--Highest Confidence Prediction
SELECT
    prediction,
    confidence
FROM predictions
WHERE confidence = (SELECT MAX(confidence) FROM predictions);


--Average Confidence အထက်ရှိတဲ့ Prediction
SELECT
    prediction,
    confidence
FROM predictions
WHERE confidence > (SELECT AVG(confidence) FROM predictions);


--Prediction ရှိတဲ့ User တွေ
SELECT
    full_name
FROM users
WHERE id IN (SELECT user_id FROM predictions);


--Prediction မလုပ်ရသေးတဲ့ User
SELECT
    full_name
FROM users
WHERE id NOT IN (SELECT user_id FROM predictions);


--EXISTS
SELECT
    full_name
FROM users AS u
WHERE EXISTS (SELECT 1 FROM predictions p WHERE p.user_id = u.id);


--NOT EXISTS
SELECT
    full_name
FROM users AS u
WHERE NOT EXISTS (SELECT 1 FROM predictions p WHERE p.user_id = u.id);


--Correlated Subquery
SELECT
    p.prediction,
    p.confidence,
    m.model_name,
    m.accuracy
FROM predictions AS p
JOIN ml_models AS m ON p.model_id = m.id
WHERE (p.confidence * 100) > m.accuracy;


--Production Dashboard Query
SELECT
    m.model_name,
    p.prediction,
    p.confidence
FROM predictions AS p
JOIN ml_models AS m ON p.model_id = m.id
WHERE p.confidence = (SELECT MAX(p2.confidence) FROM predictions AS p2
WHERE p2.model_id = p.model_id);