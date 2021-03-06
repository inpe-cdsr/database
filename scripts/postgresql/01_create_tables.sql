
----------------------------------------------------------------------------------------------------
-- Create database
----------------------------------------------------------------------------------------------------

-- Run it inside PgAdmin
-- CREATE DATABASE cdsr_register;


--------------------------------------------------
-- Drop old tables
--------------------------------------------------

DROP TABLE IF EXISTS location;
DROP TABLE IF EXISTS download;
DROP TABLE IF EXISTS security;
DROP TABLE IF EXISTS user_;
DROP TABLE IF EXISTS address;


--------------------------------------------------
-- User tables
--------------------------------------------------

CREATE TABLE address (
    id SERIAL PRIMARY KEY,
    cep TEXT NOT NULL,
    street TEXT NOT NULL,
    number TEXT NOT NULL,
    city TEXT NOT NULL,
    district TEXT NOT NULL,
    state TEXT NOT NULL,
    country TEXT NOT NULL,
    complement TEXT
);

-- fix sequence
-- SELECT setval('address_id_seq', COALESCE((SELECT MAX(id)+1 FROM address), 1), false);

CREATE TABLE user_ (
    username TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    phone TEXT NOT NULL,
    company_name TEXT NOT NULL,
    company_type TEXT NOT NULL,
    company_activity TEXT NOT NULL,
    address_id INT,
    is_admin BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT user_fkey_address_id FOREIGN KEY (address_id)
        REFERENCES address (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE index ON user_(address_id);

CREATE TABLE security (
  token TEXT PRIMARY KEY,
  username TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT security_fkey_username FOREIGN KEY (username)
      REFERENCES user_ (username)
      ON UPDATE CASCADE
      ON DELETE CASCADE
);

--------------------------------------------------
-- Download tables
--------------------------------------------------

CREATE TABLE location (
  ip TEXT PRIMARY KEY,
  longitude NUMERIC,
  latitude NUMERIC,
  city TEXT,
  district TEXT,
  region TEXT,
  region_code TEXT,
  country TEXT,
  country_code TEXT,
  continent TEXT,
  continent_code TEXT,
  zip_code TEXT,
  time_zone TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE download (
    id SERIAL PRIMARY KEY,
    item_id TEXT NOT NULL,
    collection TEXT NOT NULL,
    path TEXT NOT NULL,
    username TEXT NOT NULL,
    user_name TEXT NOT NULL,
    user_email TEXT NOT NULL,
    ip TEXT NOT NULL,
    longitude NUMERIC,
    latitude NUMERIC,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON COLUMN download.item_id IS 'bdc.items table is inside cdsr_catalog database.';
COMMENT ON COLUMN download.item_id IS 'bdc.collections table is inside cdsr_catalog database.';

CREATE INDEX download_idx_created_at_reverse ON download (created_at DESC);
CREATE INDEX download_idx_item_id_date_reverse ON download (item_id, DATE(created_at) DESC);

-- remove constraint
-- ALTER TABLE download DROP CONSTRAINT download_fkey_username;

-- table to save the logging messages related to download table
CREATE TABLE download_logging (
	id SERIAL,
	message TEXT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
