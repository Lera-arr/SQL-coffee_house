--Использование агрегатных функций 
--(SUM, COUNT, AVG, MIN, MAX)

SELECT COUNT(*)  AS "Количество кофейного напитка"
FROM coffee_drink ;

SELECT * FROM coffee_drink;

SELECT COUNT(*) AS "Количество сотрудников в фирме" 
FROM employees;

SELECT *
FROM employees;

SELECT * 
FROM "orders";

SELECT AVG(total_cost) AS "Средняя сумма чека" 
FROM "orders";

SELECT SUM(total_cost) AS "Сумма всех чеков" 
FROM "orders";

SELECT MIN(total_cost) AS "Минимальная сумма чека" 
FROM "orders";

SELECT MAX(total_cost) AS "Максимальная сумма чека"
FROM "orders";

----Операторы сравнение (>,<,>=,<=,=,!=,<>);
SELECT name AS "Название кофейного напитка", price AS "Цена <= 300 "
FROM coffee_drink
where price <= 300;

SELECT name AS "Название кофейного напитка", price AS "Цена >= 300 "
FROM coffee_drink
where price >= 300;

SELECT name AS "Название кофейного напитка", price AS "Цена не равно 300 "
FROM coffee_drink
where price <> 300;

SELECT job_title AS "Сотрудники зарабатывающие больше 35000р"
FROM job_title
where salary > 35000;

SELECT job_title AS "Сотрудники зарабатывающие меньше 35000р"
FROM job_title
where salary < 35000;

--Вывод данных из таблиц с помощью оператора WHERE;
SELECT Name AS "Имя клиента", telephone AS "Телефон"
FROM client
where  telephone SIMILAR TO '%9+%';

SELECT Name AS "Имя клиента в середине а" 
FROM client
WHERE name LIKE '%а_%';

--Использование LIMIT и OFFSET;
SELECT id AS "Проспустить 1  заказ и вывести 2 первых заказа", 
order_start_date AS "Дата начала заказа",
total_cost AS "Чек заказа"
FROM orders  OFFSET 1 LIMIT 2 ;

SELECT id AS "Проспустить 2 первых заказа", 
order_start_date AS "Дата начала заказа",
total_cost AS "Чек заказа"
FROM orders  OFFSET 2 

SELECT id AS "Вывести 3 первых заказа", 
order_start_date AS "Дата начала заказа",
total_cost AS "Чек заказа"
FROM orders  LIMIT 3 

--Сортировка записей по возрастанию и по убыванию;
SELECT Name AS "Имя напитка от А до Я"  
FROM coffee_drink
ORDER BY name ASC;

SELECT Name AS "Имя напитка от Я до А"  
FROM coffee_drink
ORDER BY name DESC;

--Логические операторы (AND,OR);
SELECT full_name AS "ФИО", birthday AS "Дата Рождения"
FROM employees
WHERE  birthday > '1990-01-01' and birthday > '1993-01-01';

SELECT job_title AS "Должность", salary AS "Оклад"
FROM job_title
WHERE (id = 1 AND job_title IS NOT NULL) OR salary  <= 20000;

--Использование IN, NOT IN;
SELECT name AS "Название", portion_size AS "Порция"
FROM coffee_drink
Where portion_size IN ('200','250')

SELECT  name AS "Название"
FROM coffee_drink
Where name NOT IN ('Мокко', 'Латте','Капучино')

--Использование регулярных выражений (LIKE, SIMILAR TO);
SELECT full_name AS "ФИО"
FROM employees
WHERE full_name LIKE 'З%';

SELECT firstname AS "Фамилия" 
FROM client
WHERE firstname LIKE '%о_%';

SELECT telephone AS "Телефон"  
FROM client
WHERE telephone LIKE '%01_%';

SELECT telephone AS "Телефон" 
FROM client
WHERE telephone SIMILAR TO '%01%';

SELECT telephone AS "Телефон"  
FROM employees
WHERE telephone SIMILAR TO '%9+%';

SELECT telephone AS "Телефон" 
FROM employees
WHERE telephone SIMILAR TO '%9{3}%';

SELECT telephone AS "Телефон"
FROM employees
WHERE telephone SIMILAR TO '%(9{3}|42+)%';

--Использование DISTINCT;
SELECT DISTINCT order_status AS "Время отдачи заказа в мин."
FROM "orders";

SELECT 
	(COUNT(*) - 
	 (SELECT COUNT(DISTINCT total_cost )
	  FROM "orders")) 
	                 AS "Кол-во повторяющихся чеков" 
FROM "orders";

--Обновление нескольких записей из разных таблиц, по разным критериям (UPDATE);

SELECT *
FROM "orders"

BEGIN;
UPDATE "orders" 
	SET total_cost = total_cost - 60
	WHERE id = 3;
ROLLBACK;

SAVEPOINT saveorders;

UPDATE "orders" 
	SET order_start_date = '2022-12-02'
	WHERE id = 1
SELECT *FROM job_title 	
UPDATE job_title 
	SET job_title  = 'Старший кассир'
	WHERE id = 3;
	
UPDATE job_title 
	SET price  = '450'
	WHERE id = 4;
	
SELECT * FROM  employees
UPDATE employees 
	SET telephone  = '+7(998)900-45-21'
	WHERE id = 1;
	
SELECT * FROM ingredients
UPDATE  ingredients
	SET "name"  = 'Молоко, вода, кофейные зерна, эспрессо'
	WHERE id = 2;
	
SELECT * FROM topping
UPDATE  topping
	SET price  = '100'
	WHERE id = 4;
	
SELECT * FROM passport
UPDATE passport 
	SET registration  = 'ул. Есенина д.34'
	WHERE id = 4;


--Удаление нескольких записей из разных таблиц, по разным критериям (DELETE);
SELECT *FROM "orders"

DELETE FROM "orders"
WHERE total_cost = 600
	
DELETE FROM "orders" 
WHERE order_start_date = '2022-12-02'
	
SELECT *FROM job_title 
DELETE FROM  job_title 
WHERE job_title  = 'Старший кассир'

SELECT * FROM  coffee_drink
DELETE FROM coffee_drink 
WHERE price  = '450'
	
SELECT * FROM  employees
DELETE FROM employees 
WHERE telephone  = '+7(998)900-45-21'
	
SELECT * FROM ingredients
DELETE FROM ingredients
WHERE name  = 'Эспрессо, вода'
	
SELECT * FROM topping
DELETE FROM   topping
WHERE price  = '100'
		
SELECT * FROM passport
DELETE FROM passport 
	WHERE registration  = 'ул. Есенина д.34'
	 

--Объединение таблиц (INNER JOIN, RIGHT JOIN, LEFT JOIN);
SELECT * FROM employees, job_title
SELECT 
	employees.full_name AS "ФИО", 
	employees.telephone AS "Телефон",
	job_title.job_title AS "Должность"
FROM employees INNER JOIN job_title 
	ON employees.position_id= job_title.id;

SELECT * FROM orders,employees
SELECT 
	employees.full_name AS "ФИО сотрудника", 
	orders.total_cost AS "Чек"
FROM employees RIGHT JOIN orders
	ON employees.id= orders.
	
SELECT * FROM coffee_drink,ingredients
SELECT 
	coffee_drink.name AS "Название напитка", 
ingredients.name AS "Состав"
FROM coffee_drink LEFT JOIN ingredients
	ON coffee_drink.id= ingredients.id

--Использование вложенных запросов;
SELECT  
coffee_drink.name AS "Название напитка",
orders.total_cost AS "Чек № 5"
FROM orders INNER JOIN order_lines
ON orders.ID = order_lines.order_id
INNER JOIN coffee_drink
ON coffee_drink.ID = order_lines.drink_id
WHere orders.id=5

SELECT
full_name AS "ФИО сотрудника кассира"
FROM employees
where position_id in (
SELECT ID
FROM job_title
WHERE job_title= 'Кассир')

SELECT
name AS "Имя клиента"
FROM client
where id in (
SELECT ID
FROM orders
WHERE total_cost = '550')

--Создание представления;
CREATE VIEW order_coffee AS
SELECT  
coffee_drink.name AS "Название напитка",
orders.total_cost AS "Чек № 5"
FROM orders INNER JOIN order_lines
ON orders.ID = order_lines.order_id
INNER JOIN coffee_drink
ON coffee_drink.ID = order_lines.drink_id
WHere orders.id=5
SELECT *
FROM order_coffee
v
--Использование транзакции.
INSERT INTO "orders"(id ,employees_ID,client_ID,order_start_date,total_cost,order_status,completion_of_the_order) 
VALUES
(7,2,1,'2022-12-4','600','5','2022-12-4'),
(8,2,2,'2022-11-18','800','0','2022-11-18'),
(9,5,4,'2022-11-28','300','7','2022-11-28'),
(10,5,5,'2022-10-7','550','0','2022-10-7'),
(11,6,5,'2022-09-1','680','5','2022-09-1'),
(12,6,6,'2022-02-8','900','2','2022-02-8');

SELECT *
FROM "orders"
SELECT *
FROM  client

BEGIN;
UPDATE "orders" 
	SET total_cost = total_cost - 18
	--WHERE id = 6;
ROLLBACK;

SAVEPOINT saveorders_new;
COMMIT;
