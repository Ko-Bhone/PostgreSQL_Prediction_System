--Confidence 0.90 အထက် Prediction တွေ
WITH high_confidence AS (
		SELECT * FROM predictions WHERE confidence > 0.09)
		SELECT * FROM high_confidence;


--Prediction Count
WITH prediction_summary AS (
	SELECT user_id, COUNT(*) AS total_predictions FROM predictions GROUP BY user_id)
	SELECT * FROM prediction_summary;


--JOIN
WITH prediction_summary AS
			(SELECT user_id, COUNT(*) AS total_predictions FROM predictions GROUP BY user_id)
			SELECT u.full_name, ps.total_predictions FROM prediction_summary AS ps
			JOIN users AS u
			ON ps.user_id = u.id;


--Average Confidence
WITH avg_confidence AS
			(SELECT AVG(confidence) AS avg_conf FROM predictions)
			SELECT prediction, confidence FROM predictions WHERE confidence >
			(SELECT avg_conf FROM avg_confidence);


--Top Model
WITH model_usage AS
		(SELECT model_id, COUNT(*) AS total FROM predictions GROUP BY model_id)
		SELECT m.model_name, mu.total FROM model_usage AS mu
		JOIN ml_models AS m ON mu.model_id = m.id
		ORDER BY mu.total DESC;


--Multiple CTE
WITH prediction_count AS
		(SELECT model_id, COUNT(*) total_prediction FROM predictions GROUP BY model_id),
	average_confidence AS
		(SELECT model_id, AVG(confidence) avg_confidence FROM predictions GROUP BY model_id)
		SELECT m.model_name, pc.total_prediction, ac.avg_confidence FROM ml_models AS m
		JOIN prediction_count AS pc ON m.id=pc.model_id
		JOIN average_confidence AS ac ON m.id=ac.model_id;


--CTE + HAVING
WITH model_usage AS
		(SELECT model_id, COUNT(*) total_prediction FROM predictions GROUP BY model_id HAVING COUNT(*)>=1)
		SELECT m.model_name, mu.total_prediction FROM model_usage mu
		JOIN ml_models m ON mu.model_id=m.id;



--Ranking Report
WITH model_statistics AS
			(SELECT model_id, COUNT(*) total_prediction,
			    AVG(confidence) AS average_confidence FROM predictions GROUP BY model_id)
			SELECT m.model_name, ms.total_prediction, ROUND(ms.average_confidence,3) FROM model_statistics AS ms
			JOIN ml_models AS m ON ms.model_id=m.id ORDER BY ms.average_confidence DESC;


--Production Example Dashboard
WITH dashboard AS
		(SELECT model_id, COUNT(*) AS total_prediction,
				AVG(confidence) AS avg_confidence,
				MAX(confidence) AS highest_confidence,
				MIN(confidence) AS lowest_confidence
				FROM predictions GROUP BY model_id)
		SELECT m.model_name, d.total_prediction,
				ROUND(d.avg_confidence,3),
				ROUND(d.highest_confidence,3),
				ROUND(d.lowest_confidence,3) FROM dashboard AS d
		JOIN ml_models AS m ON d.model_id=m.id;