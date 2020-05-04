-- // Copyright (c) Microsoft Corporation.
-- // Licensed under the MIT license.
CREATE TABLE IF NOT EXISTS testdata (
    Id          SERIAL          PRIMARY KEY NOT NULL,
    FirstName   VARCHAR(255)    NOT NULL,
    LastName    VARCHAR(255)    NOT NULL
);

INSERT INTO testdata (Id, FirstName, LastName) VALUES
(1, 'John', 'Doe'),
(2, 'Jane', 'Doe') ON CONFLICT DO NOTHING;

BEGIN;

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'pgapproleblue') THEN
        CREATE ROLE pgapproleblue LOGIN PASSWORD 'MyB@dP2\$\$wd';
    END IF;
END
$$;
GRANT SELECT ON testdata TO pgapproleblue;

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'pgapprolegreen') THEN
        CREATE ROLE pgapprolegreen LOGIN PASSWORD 'MyB@dP2\$\$wd';
    END IF;
END
$$;
GRANT SELECT ON testdata TO pgapprolegreen;

COMMIT;