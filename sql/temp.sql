-- Active: 1669863277815@@127.0.0.1@3306@ebook_store

use ebook_store;

desc carts;

select * from users;


insert into carts (user_id) values ('f58d2683-7921-11ed-83a1-b445062d2ff3');

insert into carts () values ();

select * from carts;

select username, cart_id from users;

update users set cart_id = 'd82c74f5-7927-11ed-83a1-b445062d2ff3' where username = 'tanle';
