/*
Задание 2
Спроектируйте базу данных для оптового склада, 
у которого есть поставщики товаров, персонал, постоянные заказчики. 
Поля таблиц продумать самостоятельно. 
stock
*/
-- drop database stockDB;
CREATE DATABASE stockDB;


-------------------------------------------------------------------------
-- DROP TABLE stockDB.suppliers;  
CREATE TABLE stockDB.suppliers -- поставщики товаров
(	
	 id INT AUTO_INCREMENT NOT NULL,
     country VARCHAR(30) NOT NULL,    -- страна
     nameFIO VARCHAR(30) NOT NULL,  -- имя
     messenger VARCHAR(30) DEFAULT 'Unknown',  -- мессенджер
     phone VARCHAR(20) NOT NULL, -- телефон
    typeShoe VARCHAR(100) NOT NULL, -- что поставляет
     PRIMARY KEY (id)
);

INSERT INTO stockDB.suppliers																			   
(country, nameFIO, messenger, phone, typeShoe)
VALUES
('Китай', 'господин Чан', 'viber', '(093)0000001', 'Кроссовки / Кеды' ),
('Турция', 'Махмуд', 'telegram', '(093)0000002', 'Ботинки / Муж. Туфли' ),
('Украина', 'Валера', 'whatsapp', '(093)0000003', 'Жен. Туфли / Вьетнамки' );
SELECT * FROM stockDB.suppliers;
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- DROP TABLE stockDB.staff;  
CREATE TABLE stockDB.staff -- персонал
(	
	 id INT AUTO_INCREMENT NOT NULL,
     nameFIO VARCHAR(30) NOT NULL,  -- имя
     jobTitle VARCHAR(30) NOT NULL,  -- должность
     salary double DEFAULT 0.0,  -- зарплата
     phone VARCHAR(20) NOT NULL, -- телефон     
     PRIMARY KEY (id)
);

INSERT INTO stockDB.staff																			   
(nameFIO, jobTitle, salary, phone)
VALUES
('Сергей Сергеев', 'Директор', 50000.10, '(099)0000001' ),
('Михаил Михаилов', 'Продавей', 30000.20, '(099)0000002' ),
('Светлана Светлая', 'Грузчик', 20000.30, '(099)0000003' ),
('Лева Грузовой', 'Водитель', 10000.40, '(099)0000004' );
SELECT * FROM stockDB.staff;
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- DROP TABLE stockDB.clients;  
CREATE TABLE stockDB.clients -- клиенты
(	
	-- id INT AUTO_INCREMENT NOT NULL,
     phone VARCHAR(20) NOT NULL, -- телефон   
     city VARCHAR(30) DEFAULT 'UnknownCity',    -- город
     nameFIO VARCHAR(30) NOT NULL,  -- имя
     messenger VARCHAR(30 ) DEFAULT 'Unknown',  -- мессенджер       
     PRIMARY KEY (phone)
);

INSERT INTO stockDB.clients																			   
(phone, city, nameFIO, messenger)
VALUES
( '(056)0000001', 'Киев', 'Николай', 'viber' ),
( '(056)0000002', 'Днепр', 'Сергей', 'whatsapp' ),
('(056)0000003', 'Харьков', 'Виктор', 'telegram' );
SELECT * FROM stockDB.clients;
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- DROP TABLE stockDB.stock;  
CREATE TABLE stockDB.stock -- склад
(	
	 id INT AUTO_INCREMENT NOT NULL,
     suppliersID int NOT NULL, -- поставщики товаров ID
     category VARCHAR(30) NOT NULL,  -- категория
     manufacturerID VARCHAR(30) NOT NULL,  --  id производителя
     
     purchasePrice  double NOT NULL,  -- цена закупки
     sellingPrice  double NOT NULL,  -- цена реализации
     priceShoes int NOT NULL, -- цена реализации пары обуви
     
     countBoxes int NOT NULL, -- количество коробок
     coupleBox int NOT NULL, -- пар в коробке
     size VARCHAR(30) DEFAULT 'UnknownSize', -- размерЫ  
     FOREIGN KEY(suppliersID) references suppliers(id),
     PRIMARY KEY (id)
);

INSERT INTO stockDB.stock																		   
(suppliersID, category, manufacturerID,  purchasePrice, sellingPrice, coupleBox,   priceShoes,      countBoxes,  size)
VALUES
(2, 'Ботинки', 'A-567',    50.00, 90.00, 7,     (sellingPrice / coupleBox) ,     5,  '41-1/42-1/43-2/44-2/45-1' ),
(1, 'Кроссовки', 'B-5777', 34.00, 67.00, 7,     (sellingPrice / coupleBox),      5,  '41-1/42-1/43-2/44-2/45-1' ),
(2, 'Туфли', 'M-977',      54.00, 80.00, 7,     (sellingPrice / coupleBox),      5,  '41-1/42-1/43-2/44-2/45-1' );
SELECT * FROM stockDB.stock;
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- DROP TABLE stockDB.sales; 
CREATE TABLE stockDB.sales -- продажи
(	
	 id INT AUTO_INCREMENT NOT NULL,
     dataSale datetime,
     stockID int not null,
     staffID int not null,
     countBox int not null,
     phoneIdClients VARCHAR(20) NOT NULL,
     purchasePrice  double NOT NULL,  -- цена закупки
     sellingPrice  double NOT NULL,  -- цена реализации
     difference double NOT NULL,
     FOREIGN KEY(stockID) references stockDB.stock(id),
     FOREIGN KEY(staffID) references stockDB.staff(id),
     FOREIGN KEY(phoneIdClients) references stockDB.clients(phone), 
     PRIMARY KEY (id)
);

INSERT INTO stockDB.sales																		   
(dataSale, stockID, staffID, countBox, phoneIdClients, purchasePrice, sellingPrice, difference)
VALUES
(now(), 1, 2, 2, '(056)0000001', 50.00, 90.00, (sellingPrice - purchasePrice) ),
(now(), 2, 2, 1, '(056)0000002', 34.00, 67.00, (sellingPrice - purchasePrice) ),
(now(), 3, 2, 3, '(056)0000002', 54.00, 80.00, (sellingPrice - purchasePrice) );
SELECT * FROM stockDB.sales;
