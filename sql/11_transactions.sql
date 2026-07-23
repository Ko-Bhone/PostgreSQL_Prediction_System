--INSERT
BEGIN;
INSERT INTO predictions
(
	user_id,
	model_id,
	dataset_id,
	prediction,
	confidence
)
VALUES
(
	1,
	1,
	1,
	'Spam',
	0.98
);
COMMIT;


--ROLLBACK
BEGIN;
INSERT INTO predictions
(
    user_id,
    model_id,
    dataset_id,
    prediction,
    confidence
)
VALUES
(
    2,
    1,
    1,
    'Test',
    0.50
);
ROLLBACK;


--UPDATE + COMMIT
BEGIN;
UPDATE ml_models SET accuracy = 98.50 WHERE id = 1;
COMMIT;


--DELETE + ROLLBACK
BEGIN;
DELETE FROM predictions WHERE id = 1;
ROLLBACK;


--SAVEPOINT
BEGIN;
UPDATE ml_models SET accuracy = 97.50 WHERE id = 1;
SAVEPOINT before_insert;
INSERT INTO predictions
(
    user_id,
    model_id,
    dataset_id,
    prediction,
    confidence
)
VALUES
(
    1,
    1,
    1,
    'Spam',
    0.99
);


--BACK SAVEPOINT
ROLLBACK TO SAVEPOINT before_insert;
COMMIT;


--MULTIPLE OPERATIONS
BEGIN;
INSERT INTO predictions
(
    user_id,
    model_id,
    dataset_id,
    prediction,
    confidence
)
VALUES
(
    2,
    2,
    2,
    'Positive',
    0.94
);
UPDATE ml_models SET accuracy = 96.80 WHERE id = 2;
COMMIT;


--ERROR DEMO
BEGIN;
INSERT INTO predictions
(
    user_id,
    model_id,
    dataset_id,
    prediction,
    confidence
)
VALUES
(
    999,
    1,
    1,
    'Spam',
    0.99
);
COMMIT;