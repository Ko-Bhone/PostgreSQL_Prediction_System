Project : ML Prediction Management Database
File    : 02_create_tables.sql
Purpose : Create all database tables


-- Table: users
CREATE TABLE IF NOT EXISTS users(
	id SERIAL PRIMARY KEY,
	full_name VARCHAR(100) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Table: ml_models
CREATE TABLE IF NOT EXISTS ml_models (
	id SERIAL PRIMARY KEY,
	model_name VARCHAR(100) NOT NULL,
	version VARCHAR(20) NOT NULL,
	accuracy NUMERIC(5,2) CHECK (accuracy BETWEEN 0 AND 100),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Table: datasets
CREATE TABLE IF NOT EXISTS datasets(
	id SERIAL PRIMARY KEY,
	filename VARCHAR(255) NOT NULL,
	file_size INTEGER NOT NULL CHECK(file_size > 0),
	uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Table: predictions
CREATE TABLE IF NOT EXISTS prediction(
	id SERIAL PRIMARY KEY,
	user_id INTEGER NOT NULL,
	model_id INTEGER NOT NULL,
	dataset_id INTEGER NOT NULL,
	prediction TEXT NOT NULL,
	confidence NUMERIC(4,3) CHECK(confidence BETWEEN 0 AND 1),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT fk_prediction_user
		FOREIGN KEY(user_id)
		REFERENCES users(id),

	CONSTRAINT fk_prediction_model
		FOREIGN KEY(model_id)
		REFERENCES ml_models(id),

	CONSTRAINT fk_prediction_dataset
		FOREIGN KEY(dataset_id)
		REFERENCES datasets(id)
);