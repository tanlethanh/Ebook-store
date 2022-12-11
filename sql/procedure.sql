-- Active: 1669863277815@@127.0.0.1@3306@ebook_store

drop PROCEDURE temp1;

CREATE PROCEDURE temp1 (in book_id varchar(36), in cart_id varchar(36))
BEGIN
    declare new_cart_item_id varchar(36);
    set new_cart_item_id = uuid()

    insert into CartItems (id, book_id, quantity, )
	
END;

select cart_id from users where id = 'f58d2683-7921-11ed-83a1-b445062d2ff3';

DROP TRIGGER before_insert_cart_item;

CREATE TRIGGER before_insert_cart_item
BEFORE INSERT ON CartItems FOR EACH ROW
BEGIN
    DECLARE book_quantity int;
    DECLARE num_book int;
    DECLARE count_cartitem int;

    SELECT count(*) into count_cartitem from CartItems 
        where state = 'NOW' and cart_id = new.cart_id and book_id = new.book_id;

    IF count_cartitem <> 0 then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Món này đã có trong giỏ hàng!';
    END IF;
    
    SELECT quantity, count(*) INTO book_quantity, num_book
        from books where id = new.book_id;
        
    IF num_book = 0 then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Sách này hiện không tìm thấy!';
    ELSEIF book_quantity < new.quantity then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Số lượng sách không đủ để thêm vào giỏ hàng!';
    END IF;

END;


desc cartitems;
select * from books limit 2;
select * from carts limit 2;

insert into cartitems (book_id, cart_id, quantity) VALUES (
    '742c7d8f-750f-11ed-b055-b445062d2ff3',
    '9b0d2f5c-7924-11ed-83a1-b445062d2ff3',
    10
);

select price, discount from books where id = '742c7d8f-750f-11ed-b055-b445062d2ff3';

select * from cartitems;
    
