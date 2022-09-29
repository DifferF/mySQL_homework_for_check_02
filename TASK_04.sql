
/*
Задание 4
Спроектируйте базу данных для системы отдела кадров
*/
/*  DROP блок

drop database humanResourcesBD;
DROP TABLE humanResourcesBD.workers;  
DROP TABLE humanResourcesBD.workingPosition;  
DROP TABLE humanResourcesBD.workplace; 
DROP TABLE humanResourcesBD.holiday; 
DROP TABLE humanResourcesBD.basicSummary;
*/

CREATE DATABASE humanResourcesBD;

-------------------------------------------------------------------------
-- DROP TABLE humanResourcesBD.workers;  
CREATE TABLE humanResourcesBD.workers -- работники 
(	
	 id INT AUTO_INCREMENT NOT NULL,
     surnamesN VARCHAR(30) NOT NULL,    -- Фамили
     nameN VARCHAR(30) NOT NULL,  -- Имя
     patronymicN VARCHAR(30) DEFAULT 'Unknown',  -- Отчество
	 dateBirth DATE NOT NULL, -- дата рождения
	 receiptDate DATE NOT NULL, -- дата поступления на работу
     phone VARCHAR(20) NOT NULL, -- телефон
     PRIMARY KEY (id)
);

INSERT INTO humanResourcesBD.workers																			   
(surnamesN, nameN, patronymicN, dateBirth, receiptDate, phone)
VALUES
('Миронов', 'Константин', 'Викторович', '1981-11-11', now(), '(093)0000001' ),
('Константинов', 'Сергей', 'Викторович', '1982-11-11', now(), '(093)0000002' ),
('Викторов', 'Сергей',  DEFAULT, '1983-11-11', now(), '(093)0000003' );

SELECT * FROM humanResourcesBD.workers;
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- DROP TABLE humanResourcesBD.workingPosition;  
CREATE TABLE humanResourcesBD.workingPosition --  должность + зп
(	
	 id INT AUTO_INCREMENT NOT NULL,
     jobTitle VARCHAR(30) NOT NULL,    	-- Должность
     salary double NOT NULL, 			-- Зарлата     
     PRIMARY KEY (id)
);

INSERT INTO humanResourcesBD.workingPosition																			   
(jobTitle, salary)
VALUES
('директор', 110000.00),
('зам директора', 120000.00),
('бухгалтер', 130000.00),
('менеджер среднего звена', 140000.00),
('топ менеджер', 150000.00),
('менеджер', 160000.00),
('водитель', 170000.00),
('дизайнер', 18000.00);

SELECT * FROM humanResourcesBD.workingPosition;
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- DROP TABLE humanResourcesBD.workplace;  
CREATE TABLE humanResourcesBD.workplace --  рабочее место
(	
	 id INT AUTO_INCREMENT NOT NULL,
     floorW int default 0, 	-- этаж
     officeW int default 0, -- офис  
     tableW int default 0, 	-- стол
     automobile VARCHAR(3) default 'нет', -- автомобиль
     PRIMARY KEY (id)
);

INSERT INTO humanResourcesBD.workplace																			   
(floorW, officeW, tableW, automobile)
VALUES
(1, 100, 1, default),
(1, 100, 2, default),
(1, 100, 3, default),

(1, 110, 1, default),
(1, 110, 2, default),
(1, 110, 3, default),

(2, 201, 1, default),
(2, 201, 2, default),
(2, 201, 3, default),

(default, default, default, 'да');
SELECT * FROM humanResourcesBD.workplace;
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- DROP TABLE humanResourcesBD.workingDays;  
CREATE TABLE humanResourcesBD.workingDays --  рабочии дни
(	
	 id INT AUTO_INCREMENT NOT NULL,
     Monday VARCHAR(3) NOT NULL, 
     Tuesday VARCHAR(3) NOT NULL, 
	 Wednesday VARCHAR(3) NOT NULL, 
	 Thursday VARCHAR(3) NOT NULL, 
	 Friday VARCHAR(3) NOT NULL, 
	 Saturday VARCHAR(3) NOT NULL, 
	 Sunday VARCHAR(3) NOT NULL, 
     PRIMARY KEY (id)
);

INSERT INTO humanResourcesBD.workingDays																			   
(Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday)
VALUES
('раб', 'раб', 'вых','раб', 'раб','вых','раб'),
('раб', 'раб', 'раб','раб', 'раб','вых','вых');
SELECT * FROM humanResourcesBD.workingDays;
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- DROP TABLE humanResourcesBD.holiday;  
CREATE TABLE humanResourcesBD.holiday --  отпуск
(	
	 id INT AUTO_INCREMENT NOT NULL,
     workersId int not null,
     dateBeginning date not null,
     amountDays int not null,     
     FOREIGN KEY(workersId) references humanResourcesBD.workers(id),	 
     PRIMARY KEY (id)
);

INSERT INTO humanResourcesBD.holiday																			   
(workersId, dateBeginning, amountDays)
VALUES
(1, '2022-11-11', 20),
(2, '2022-10-11', 22),
(3, '2022-12-11', 25);
SELECT * FROM humanResourcesBD.holiday;
-------------------------------------------------------------------------


-- DROP TABLE humanResourcesBD.basicSummary;
CREATE TABLE humanResourcesBD.basicSummary  --  базовая сводноя
(	
	 id INT AUTO_INCREMENT NOT NULL,
     workersId int not null,
     workingPositionId int not null,
     workplaceId int not null,
     workingDaysId int not null,
     workersName VARCHAR(100) NOT NULL,     
       
     FOREIGN KEY(workersId) references humanResourcesBD.workers(id),	 
     FOREIGN KEY(workingPositionId) references humanResourcesBD.workingPosition(id),
     FOREIGN KEY(workplaceId) references humanResourcesBD.workplace(id),
     FOREIGN KEY(workingDaysId) references humanResourcesBD.workingDays(id),
     
     PRIMARY KEY (id)
);

INSERT INTO humanResourcesBD.basicSummary																			   
 (workersId, workingPositionId, workplaceId, workingDaysId , workersName)
VALUES
 (1, 1, 1, 2 , (select CONCAT(surnamesN, ' ', nameN) FROM humanResourcesBD.workers where id = 1)),
 (2, 7, 10, 2 , (select CONCAT(surnamesN, ' ', nameN) FROM humanResourcesBD.workers where id = 2)),
 (3, 4, 8, 1 , (select CONCAT(surnamesN, ' ', nameN) FROM humanResourcesBD.workers where id = 3));
SELECT * FROM humanResourcesBD.basicSummary;
