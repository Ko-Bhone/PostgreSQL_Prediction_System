-- USERS
SELECT * FROM users;
INSERT INTO users(
	full_name,
	email
)
VALUES
('Aung Aung','aung@gmail.com'),
('Su Su','susu@gmail.com'),
('Ko Ko','koko@gmail.com'),
('Hla Hla', 'hlahal@gmail.com'),
('Kyaw Kyaw','kyawkyaw@gmail.com');


-- ML MODELS
INSERT INTO ml_models(
	model_name,
	version,
	accuracy
)
VALUES
('Spam Detector', '1.0', 95.20),
('Image Classifier', '2.1',98.45),
('Sentiment Analyzer', '1.5', 94.80),
('Fraud Detection', '3.0', 99.10);


-- DATASETS
INSERT INTO datasets (
	file_name,
	file_size
)
VALUES
('emails.csv',2048),
('cats_vs_dogs_csv',5024),
('reviews.csv',1820),
('transactions.csv',8900);


- PREDICTIONS
INSERT INTO prediction (
    user_id,
    model_id,
    dataset_id,
    prediction,
    confidence
)
VALUES
(1, 1, 1, 'Spam', 0.987),
(2, 3, 3, 'Positive', 0.921),
(3, 2, 2, 'Cat', 0.973),
(4, 4, 4, 'Fraud', 0.998),
(5, 1, 1, 'Not Spam', 0.853);