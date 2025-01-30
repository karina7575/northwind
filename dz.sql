-- 3.1. Посчитать количество заказов за все время. Смотри таблицу orders. Вывод: количество заказов.

SELECT COUNT(*) "Количество заказов"
FROM orders as o;

--3.2. Посчитать сумму денег по всем заказам за все время (учитывая скидки).  
-- Смотри таблицу order_details. Вывод: id заказа, итоговый чек (сумма стоимостей всех  продуктов со скидкой)

SELECT product_id, SUM(unit_price + (discount * unit_price)) "Итоговый чек"
FROM order_details
GROUP BY product_id;

--3.3. Показать сколько сотрудников работает в каждом городе. Смотри таблицу employee. Вывод: наименование города и количество сотрудников

SELECT city "Наименование города", COUNT (employee_id) "Количество сотрудников"
FROM employees
GROUP BY city;

--3.4. Показать фио сотрудника (одна колонка) и сумму всех его заказов 

SELECT CONCAT(first_name, ' ', last_name) "ФИО сотрудника", SUM (od.unit_price) "Сумма его заказов"
FROM employees e
JOIN orders o ON e.employee_id = o.employee_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY CONCAT(first_name, ' ', last_name);

--3.5. Показать перечень товаров от самых продаваемых до самых непродаваемых (в штуках). - Вывести наименование продукта и количество проданных штук.

SELECT p.product_name, count(o.order_id)
FROM products p
JOIN order_details od ON p.product_id = od.product_id
JOIN orders o ON od.order_id = o.order_id
GROUP BY p.product_id 
ORDER BY count(o.order_id) DESC;
