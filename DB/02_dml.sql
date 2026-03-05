USE seating_db;

-- Floor 1
INSERT INTO SeatingChart VALUES (1,1,1);
INSERT INTO SeatingChart VALUES (2,1,2);
INSERT INTO SeatingChart VALUES (3,1,3);
INSERT INTO SeatingChart VALUES (4,1,4);

-- Floor 2
INSERT INTO SeatingChart VALUES (5,2,1);
INSERT INTO SeatingChart VALUES (6,2,2);
INSERT INTO SeatingChart VALUES (7,2,3);
INSERT INTO SeatingChart VALUES (8,2,4);

-- Floor 3
INSERT INTO SeatingChart VALUES (9,3,1);
INSERT INTO SeatingChart VALUES (10,3,2);
INSERT INTO SeatingChart VALUES (11,3,3);
INSERT INTO SeatingChart VALUES (12,3,4);

-- Floor 4
INSERT INTO SeatingChart VALUES (13,4,1);
INSERT INTO SeatingChart VALUES (14,4,2);
INSERT INTO SeatingChart VALUES (15,4,3);
INSERT INTO SeatingChart VALUES (16,4,4);

-- Employees
INSERT INTO Employee VALUES ('00101','Alice','alice@company.com',1);
INSERT INTO Employee VALUES ('00102','Bob','bob@company.com',2);
INSERT INTO Employee VALUES ('00103','Charlie','charlie@company.com',NULL);
INSERT INTO Employee VALUES ('00104','David','david@company.com',NULL);
INSERT INTO Employee VALUES ('00105','Eve','eve@company.com',5);