--CREATE INDEX ON users > email
CREATE INDEX idx_user_email ON users(email);
SELECT * FROM users WHERE email = 'aung@example.com';


--INDEX FOR ACCURACY
CREATE INDEX idx_models_accuracy ON ml_models (accuracy);
SELECT * FROM ml_models WHERE accuracy > 95;


--FOREIGN KEY INDEX
CREATE INDEX idx_predictions_user ON predictions(user_id);
CREATE INDEX idx_predictions_models ON predictions(model_id);
CREATE INDEX idx_predictions_dataset ON predictions(dataset_id);


--COMPOSITE INDEX
CREATE INDEX idx_prediction_model_confidence ON predictions
			(model_id,confidence);
SELECT * FROM predictions WHERE model_id = 1 AND confidence > 0.90;


--UNIQUE INDEX
CREATE UNIQUE INDEX idx_unique_email ON users(email);
  ("if email's column is unique > no need Upper index query")


--DROP INDEX
DROP INDEX IF EXISTS idx_predictions_confidence;
DROP INDEX IF EXISTS idx_models_accuracy;

