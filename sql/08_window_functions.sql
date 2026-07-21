--ROW_NUMBER()
SELECT id, prediction, confidence,
		ROW_NUMBER() OVER(ORDER BY confidence DESC) AS row_number
		FROM predictions;


--RANK()
SELECT prediction, confidence,
		RANK() OVER(ORDER BY confidence DESC) AS ranking
		FROM predictions;


--DENSE_RANK()
SELECT prediction, confidence,
		DENSE_RANK() OVER(ORDER BY confidence DESC) AS dense_rank
		FROM predictions;


--PARTITION_BY
SELECT model_id, prediction, confidence,
		ROW_NUMBER() OVER(PARTITION BY model_id ORDER BY confidence DESC) AS ranking
		FROM predictions;


--LAG()
SELECT prediction, confidence,
		LAG(confidence) OVER(ORDER BY created_at) AS previous_confidence
		FROM predictions;


--LEAD()
SELECT id, confidence,
        LEAD(confidence) OVER(ORDER BY created_at) AS next_confidence
        FROM predictions;


--Running Total
SELECT id, created_at, COUNT(*)
		OVER(ORDER BY created_at) AS running_total
		FROM predictions;


--AVERAGE PER MODEL
SELECT model_id, prediction, confidence,
		AVG(confidence) OVER(PARTITION BY model_id) AS model_average
		FROM predictions;


--PRODUCTION QUERY
WITH ranked_prediction AS
		(SELECT id, model_id, prediction, confidence,
		ROW_NUMBER() OVER(PARTITION BY model_id ORDER BY confidence DESC) AS rn
		FROM predictions)
		SELECT m.model_name, rp.prediction, rp.confidence FROM ranked_prediction rp
		JOIN ml_models m ON rp.model_id=m.id WHERE rn=1;


--PRODUCTION DASHBOARD
SELECT m.model_name, p.prediction, p.confidence,
		ROW_NUMBER() OVER(PARTITION BY m.model_name ORDER BY confidence DESC) AS ranking, AVG(confidence)
		OVER(PARTITION BY m.model_name) AS average_confidence
		FROM predictions AS p JOIN ml_models AS m ON p.model_id=m.id;