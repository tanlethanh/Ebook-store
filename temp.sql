-- Active: 1669863277815@@127.0.0.1@3306@ebook_store
select * from books;


SELECT c.name as root_category, sc.name as spec_category, sc.id as specific_category_id, count(b.id)
FROM categories AS c 
INNER JOIN specificcategories as sc ON c.id = sc.category_id
LEFT JOIN books as b ON b.specific_category_id = sc.id
GROUP BY root_category, spec_category