CREATE DATABASE city_bank;
USE city_bank;
CREATE TABLE friend (
    friend_id INT(10) AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(60) NOT NULL,
    brith_date varchar(20),
    ssn VARCHAR(20) NOT NULL
);
CREATE TABLE client (
    client_id INT(10) AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    addres VARCHAR(60) NOT NULL,
    type VARCHAR(10) NOT NULL
);
CREATE TABLE branch (
    branch_id INT(10) AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(60) NOT NULL,
    manager_id INT(10) NOT NULL
);
CREATE TABLE account (
    account_id INT(10) AUTO_INCREMENT NOT NULL PRIMARY KEY,
    balance DOUBLE NOT NULL,
    type VARCHAR(10) NOT NULL,
    branch_id INT(10) NOT NULL,
    FOREIGN KEY (branch_id)
        REFERENCES branch (branch_id)
);
DROP TABLE client_account;
CREATE TABLE client_account (
    client_id INT(10)  NOT NULL PRIMARY KEY,
    account_id INT(10) NOT NULL,
    FOREIGN KEY (client_id)
        REFERENCES client (client_id),
    FOREIGN KEY (account_id)
        REFERENCES account (account_id)
);
INSERT INTO client(name,addres,type)values
('Sigal,Tobias','56 Clayton Road','B'),
('Vega, Adam','275 Evergreen Road','F'),
('Nayer, Julia','56 Diablo Blvd','B'),
('Colmena, Karen','4323 Oak Road','F'),
('Volman, Shanta','4323 Sky Road','F'),
('Weiss, Matthew','Av. Trabajo 5','B'),
('Mourgos, Kevin','Hidalgo 74','B'),
('Brenden, Carlos','12 Sky Blvd','B');
INSERT INTO friend(name,address,ssn)VALUES
('Roberts, Joseph','22 Diablo Blvd','234-45-5688');
INSERT INTO friend(name,address,brith_date,ssn)VALUES
('Ledesma, Roberto','453 Main St','1960-03-05','255-45-5688');
INSERT INTO friend(name,address,brith_date,ssn)VALUES
('Mark, Nancy','232 Concord Road',null,'234-77-5688'),
('Kenny, Tom','123 Oak Road','1972-01-12','134-65-9288');
INSERT INTO branch(name,address,manager_id)VALUES
('Centro','45 Main St',9823),
('Bellavista','23 Treat Blvd','1768');
INSERT INTO account(balance,type,branch_id)VALUES
('234.56','S',1),
('12756.56','C',1),
('-1756.56','S',1),
('-456.78','C',1),
('2456.78','C',1),
('1223.67','S',2),
('323.97','S',2),
('89.65','S',2),
('2789.65','S',2);
INSERT INTO client_account(client_id,account_id)VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8);
SELECT 
    *
FROM
    client;
SELECT 
    *
FROM
    client
WHERE
    name = 'Vega, Adam';
SELECT 
    *
FROM
    client
WHERE
    name = 'Cruise, Tom';
SELECT 
    *
FROM
    client
WHERE
    client_id = 2;
SELECT 
    *
FROM
    client
WHERE
    type = 'B' AND name = 'Nayer, Julia';
SELECT 
    *
FROM
    client
WHERE
    client_id = 4 OR name = 'Colmena, Karen';
SELECT 
    *
FROM
    client
WHERE
    client_id > 3 OR name = 'Vega, Adam';
SELECT 
    name
FROM
    client;
SELECT 
    name, address
FROM
    branch;
SELECT 
    friend_id, name, brith_date
FROM
    friend
WHERE
    brith_date IS NULL;
SELECT 
    friend_id, name, brith_date
FROM
    friend
WHERE
    brith_date IS NOT NULL;
SELECT 
    client_id
FROM
    client_account;
SELECT DISTINCT
    client_id
FROM
    client_account;
SELECT 
    account_id, balance
FROM
    account
WHERE
    balance > 100;
SELECT 
    account_id, balance, type
FROM
    account
WHERE
    balance > 100;
SELECT 
    name, addres, type
FROM
    client
ORDER BY name ASC;
SELECT 
    name, addres, type
FROM
    client
ORDER BY name DESC;

SELECT 
    name, account_id
FROM
    client,
    client_account;
SELECT 
    name, account_id
FROM
    client,
    client_account
WHERE
    client_account.client_id = client.client_id;
SELECT 
    c.name, ca.client_id, ca.account_id
FROM
    client c,
    client_account ca
WHERE
    ca.client_id = c.client_id;
SELECT 
    c.client_id, a.account_id, balance, name
FROM
    client c,
    client_account ca,
    account a
WHERE
    ca.account_id = a.account_id
        AND c.client_id = ca.client_id;
SELECT 
    name, balance
FROM
    client c,
    account a,
    client_account ca
WHERE
    ca.account_id = a.account_id
        AND c.client_id = ca.client_id
        AND balance > 100; 

CREATE VIEW vw_buss AS
    SELECT 
        name, REPLACE(type, 'B', 'Business') AS type
    FROM
        client
    WHERE
        type = 'B';
SELECT 
    name, type
FROM
    vw_buss;
SELECT 
    account_id, type
FROM
    account
WHERE
    type <> 'C';
SELECT 
    b.account_id, b.type, a.name
FROM
    client a,
    account b,
    client_account c
WHERE
    b.account_id = c.account_id
        AND c.client_id = a.client_id
        AND b.type <> 'C';
CREATE VIEW vw_account AS
    SELECT 
        branch_id
    FROM
        branch
    WHERE
        name <> 'Bellavista';
create view vw_type as
select account_id
from account
where type<>'S';
set sql_safe_updates=0;
UPDATE account 
SET 
    balance = '0.0000'
WHERE
    balance < '0';

SELECT 
    account_id, balance, ABS(balance) AS dinero
FROM
    account;
CREATE VIEW vw_cost AS
    SELECT 
        item_id, cost
    FROM
        item
    WHERE
        item_id = '2000';
create user andrew identified by 'easy78';
grant all privileges on *.* to 'andrew'@'%';
drop user andrew;
grant select on friend to andrew;
grant select,update on friend to andrew;
grant select on friend to PUBLIC;

start transaction;
insert into friend(name,address,brith_date,ssn)
values('Conreras, Marco','Hidalgo 50','1990-03-29','123-45-7788');
rollback;

