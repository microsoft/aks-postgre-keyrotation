DROP TABLE IF EXISTS testdata;
CREATE TABLE testdata (
    Id          SERIAL          PRIMARY KEY NOT NULL,
    FirstName   VARCHAR(255)    NOT NULL,
    LastName    VARCHAR(255)    NOT NULL
);
INSERT INTO testdata (FirstName, LastName) VALUES
('John', 'Doe'),
('Jane', 'Doe');
SELECT * FROM testdata;