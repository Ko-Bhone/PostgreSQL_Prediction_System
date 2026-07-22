--PREDICTION REPORT
CREATE OR REPLACE VIEW prediction_report AS
		SELECT p.id, u.full_name, m.model_name, d.file_name, p.prediction, p.confidence, p.created_at FROM predictions AS p
		JOIN users AS u ON p.user_id = u.id
		JOIN ml_models AS m ON p.model_id = m.id
		JOIN datasets AS d ON p.dataset_id = d.id;


--HIGH CONFIDENCE PREDICTIONS
CREATE OR REPLACE VIEW high_confidence_predictions AS
		SELECT * FROM prediction_report	WHERE confidence >= 0.95;


--MODEL PERFORMANCE
CREATE OR REPLACE VIEW model_performance AS
		SELECT m.model_name, COUNT(p.id) AS total_predictions,
		ROUND(AVG(p.confidence),3) AS average_confidence,
		ROUND(MAX(p.confidence),3) AS highest_confidence,
		ROUND(MIN(p.confidence),3) AS lowest_confidence FROM predictions AS p
		JOIN ml_models AS m ON p.model_id = m.id
		GROUP BY m.model_name;


--USER ACTIVITY
CREATE OR REPLACE VIEW user_activity AS
		SELECT u.full_name, COUNT(p.id) AS total_prediction FROM users AS u
		LEFT JOIN predictions AS p ON u.id = p.user_id
		GROUP BY u.full_name;


--DATASET SUMMARY
CREATE OR REPLACE VIEW dataset_summary AS
		SELECT d.file_name, COUNT(p.id) AS total_predictions FROM datasets AS d
		LEFT JOIN predictions AS p ON d.id = p.dataset_id
		GROUP BY d.file_name;


--TOP MODELS
CREATE OR REPLACE VIEW top_models AS
		SELECT model_name, average_confidence FROM model_performance
		ORDER BY average_confidence DESC


--MAKE VIEW > QUERY
SELECT * FROM prediction_report;
SELECT * FROM model_performance;
SELECT * FROM user_activity;
SELECT * FROM top_models;


--DROP VIEW
DROP VIEW IF EXISTS prediction_report;
DROP VIEW IF EXISTS model_performance;
DROP VIEW IF EXISTS user_activity;
DROP VIEW IF EXISTS top_models;


--VIEW + WHERE
SELECT * FROM prediction_report WHERE confidence > 0.90;


--VIEW + ORDER BY
SELECT * FROM prediction_report ORDER BY confidence DESC;


--VIEW + GROUP BY
SELECT model_name, COUNT(*) FROM prediction_report GROUP BY model_name;

