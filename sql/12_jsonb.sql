--CREATE JSONB COLUMN
ALTER TABLE predictions ADD COLUMN metadata JSONB;


--ADD JSON DATA
UPDATE predictions SET metadata = '{"device":"mobile",
									"browser":"chrome",
									"language":"en",
									"model_version":"1.0"}'::jsonb WHERE id=1;


--TAKEN JSON ONE KEY
SELECT metadata -> 'device' FROM predictions;


--TAKEN JSON VALUE
SELECT metadata ->> 'device' FROM predictions;


--WHERE + JSON
SELECT prediction, confidence FROM predictions WHERE metadata ->> 'device' = 'mobile';


--NESTED JSON
UPDATE predictions SET metadata=
					'{"device":"mobile",
					"metrics":{"precision":0.95,
					"recall":0.92}}'::jsonb WHERE id=1;
SELECT metadata -> 'metrics' ->> 'precision' FROM predictions;


--MODEL VERSION INCLUDE IN 1.0
SELECT id, prediction FROM predictions WHERE metadata @> '{"model_version":"1.0"}';


--JSON UPDATE
UPDATE predictions SET metadata =
				jsonb_set(metadata,'{browser}', '"firefox"')
				WHERE id = 1;


--ADD JSON KEY
UPDATE predictions SET metadata =
						jsonb_set(metadata,'{country}','"Myanmar"')
						WHERE id = 1;


--GIN INDEX
UPDATE predictions SET metadata =
						jsonb_set(metadata,'{country}','"Myanmar"')
						WHERE id = 1;


--PRODUCTION QUERY
UPDATE predictions SET metadata =
						jsonb_set(metadata,'{country}','"Myanmar"')
						WHERE id = 1;


--ML EXAMPLE > MODEL EVALUATION METRICS
UPDATE predictions SET metadata =
			'{"metrics":{"accuracy":0.98,
						"precision":0.96,
						"recall":0.94,
						"f1_score":0.95},
				"model":"Spam Detector",
				"version":"2.1"}' :: jsonb
			WHERE id = 2;
SELECT metadata -> 'metrics' ->> 'accuracy' FROM predictions WHERE id=2;