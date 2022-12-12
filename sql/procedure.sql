-- Active: 1670753632697@@127.0.0.1@3306@ebook_store

/* Check valid action ADD BOOK TO CART */
DROP TRIGGER IF EXISTS before_insert_cart_item;
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

/* insert into cartitems (book_id, cart_id, quantity) VALUES (
    '742c7d8f-750f-11ed-b055-b445062d2ff3',
    '9b0d2f5c-7924-11ed-83a1-b445062d2ff3',
    10
); */
    
--------------+


-- DROP FUNCTION caculate_total_price;
CREATE FUNCTION caculate_total_price(discount float, price int) RETURNS FLOAT
DETERMINISTIC
BEGIN
    RETURN price * (1 - discount);
END;

SELECT caculate_total_price(0.4, 123123);


/* Get cart by id */
SELECT b.name as bookName, b.id as bookId, b.quantity as curQuantity, 
ci.quantity as quantity, b.price as price, b.discount as discount,
caculate_total_price(b.discount, b.price) as totalPrice, b.main_image_url as imageUrl
FROM cartitems AS ci
LEFT JOIN books as b ON ci.book_id = b.id
WHERE ci.cart_id = '9b0d2f5c-7924-11ed-83a1-b445062d2ff3' and ci.state = 'NOW';

select * from cartitems;

delete from cartitems WHERE cart_id = '' and book_id = '';