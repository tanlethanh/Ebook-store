-- Active: 1669863277815@@127.0.0.1@3306@ebook_store


create function get_total_price(_order_id varchar(36)) returns float DETERMINISTIC
begin 
    declare total int default 0;
    declare _quantity int;
    declare _price int;
    declare _discount float;
    declare _done int default false;
    declare ob_cursor CURSOR for (select quantity, price, discount from orderbooks where order_id = _order_id);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET _done = TRUE;

    open ob_cursor;

    read_loop: LOOP
        FETCH ob_cursor INTO _quantity, _price, _discount;
        IF _done THEN LEAVE read_loop;
        END IF;

        set total = total + (_price * (1 - _discount)) * _quantity;

    END LOOP;

    close ob_cursor;
    return total;
end;

select u.name as name, u.phone_number as phone_number, u.email as email, get_total_price(o.id) as total_price from orders as o
left join users as u on u.id = o.user_id 
where o.id = '49389e0a-7a59-11ed-a4f0-b445062d2ff3';

select b.name as book_name, 
    b.main_image_url as book_image, 
    ob.discount as discount, 
    ob.quantity as quantity, 
    ob.price as price,
    (ob.price * (1 - ob.discount)) as discount_price
from orders as o
join orderbooks as ob on o.id = ob.order_id
join books as b on b.id = ob.book_id
where o.id = '49389e0a-7a59-11ed-a4f0-b445062d2ff3';

select * from orders where user_id is not NULL order by init_date desc;

select * from orderbooks where order_id = '49389e0a-7a59-11ed-a4f0-b445062d2ff3';

select get_total_price('49389e0a-7a59-11ed-a4f0-b445062d2ff3');

select 42480 * (1 - 0.41) + 67940 * (1 - 0.21);

select * from orderbooks;

select * from users limit 1, 1;

