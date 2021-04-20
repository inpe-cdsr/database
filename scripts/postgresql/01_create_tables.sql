
--------------------------------------------------
-- Create table
--------------------------------------------------

-- Run it inside PgAdmin
-- CREATE DATABASE cdsr_register;


--------------------------------------------------
-- User
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

CREATE TABLE user_ (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    username TEXT NOT NULL,
    email TEXT NOT NULL,
    password TEXT NOT NULL,
    phone TEXT NOT NULL,
    company_name TEXT NOT NULL,
    company_type TEXT NOT NULL,
    company_activity TEXT NOT NULL,
    address_id INT,
    is_admin BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_user_address_id FOREIGN KEY (address_id)
        REFERENCES address (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE security (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  token TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_security_user_id FOREIGN KEY (user_id)
      REFERENCES user_ (id)
      ON UPDATE CASCADE
      ON DELETE CASCADE
);

--------------------------------------------------
-- Download
--------------------------------------------------

CREATE TABLE location (
  ip TEXT PRIMARY KEY,
  long NUMERIC,
  lat NUMERIC,
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
    user_id INT NOT NULL,
    user_name TEXT NOT NULL,
    user_email TEXT NOT NULL,
    ip TEXT NOT NULL,
    long NUMERIC,
    lat NUMERIC,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_download_user_id FOREIGN KEY (user_id)
        REFERENCES user_ (id)
        ON UPDATE CASCADE
);

COMMENT ON COLUMN download.item_id IS 'bdc.items table is inside cdsr_catalog database.';
COMMENT ON COLUMN download.item_id IS 'bdc.collections table is inside cdsr_catalog database.';
