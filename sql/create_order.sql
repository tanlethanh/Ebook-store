-- Active: 1670753632697@@127.0.0.1@3306@ebook_store

-- DROP FUNCTION SPLIT_STR;

-- DROP TRIGGER IF EXISTS BEFORE_INSERT_ORDER;

-- drop PROCEDURE create_new_order;

CREATE FUNCTION SPLIT_STR(X VARCHAR(255), DELIM VARCHAR
(12), POS INT) RETURNS VARCHAR(255) DETERMINISTIC 
BEGIN 
	RETURN
	REPLACE (
	        SUBSTRING(
	            SUBSTRING_INDEX(x, delim, pos),
	            CHAR_LENGTH(
	                SUBSTRING_INDEX(x, delim, pos -1)
	            ) + 1
	        ),
	        delim,
	        ''
	    );
END; 


/* ------------------------------------------------------------------------------------------- */
ALTER TABLE ORDERS MODIFY COLUMN address_id varchar(36);

CREATE TRIGGER BEFORE_INSERT_ORDER BEFORE INSERT ON 
ORDERS FOR EACH ROW BEGIN 
	DECLARE address_id varchar(36) default uuid();
	INSERT INTO
	    address (
	        id,
	        province,
	        district,
	        wards,
	        country,
	        home
	    )
	values (address_id, '', '', '', '', '');
	SET new.address_id = address_id;
END; 

/* Create new order by list of book id and list of quantity, separate by '|' */

drop PROCEDURE create_new_order;

CREATE PROCEDURE CREATE_NEW_ORDER(IN LIST_BOOK_ID VARCHAR
(255), IN LIST_QUANTITY VARCHAR(255), IN _USER_ID VARCHAR(36), OUT ORDER_ID_OUT VARCHAR(36)) BEGIN 
	DECLARE id_index INT Default 0;
	DECLARE quantity_index INT Default 0;
	DECLARE book_id VARCHAR(255);
	DECLARE order_id VARCHAR(36);
	DECLARE _quantity int;
	DECLARE _quantity_str varchar(255);
	DECLARE cur_quantity int;
	DECLARE _price int Default 0;
	DECLARE _discount float Default 0;
	--eror handler
	DECLARE msg TEXT;
	DECLARE result TEXT;
	set id_index = 0;
	set quantity_index = 0;
	START TRANSACTION;
	SET order_id = uuid();
	INSERT INTO
	    orders (
	        id,
	        receiver_name,
	        phone_number,
	        total_price,
			user_id
	    )
	values (order_id, '', '', 0, _USER_ID);
	item_loop: LOOP 
	/* # Get id  */
	SET id_index = id_index + 1;
	SET book_id = SPLIT_STR(list_book_id, '|', id_index);
	/* # Get quantity  */
	SET quantity_index = quantity_index + 1;
	SET
	    _quantity_str = SPLIT_STR(
	        list_quantity,
	        '|',
	        quantity_index
	    );
	IF ( book_id = '' and _quantity_str = '' ) THEN LEAVE item_loop;
	ELSEIF ( book_id = '' or _quantity_str = '' ) THEN ROLLBACK;
	SIGNAL SQLSTATE '45000'
	SET
	    MESSAGE_TEXT = 'Danh sách sản phẩm và số lượng không khớp!';
	END IF;

	SET _quantity = CONVERT(_quantity_str, SIGNED INTEGER);
	IF _quantity <= 0 THEN ROLLBACK;
	SIGNAL SQLSTATE '45000'
	SET
	    MESSAGE_TEXT = 'Số lượng sản phẩm cần mua phải lớn hơn 0!';
	END IF;
	SELECT
	    quantity, price, discount into cur_quantity, _price, _discount
	from books
	where id = book_id;
	IF cur_quantity < _quantity THEN ROLLBACK;
	SIGNAL SQLSTATE '45000'
	SET
	    MESSAGE_TEXT = 'Số lượng sản phẩm hiện không đủ!';
	END IF;
	
	INSERT INTO
	    orderbooks(
	        order_id,
	        book_id,
	        price,
	        discount,
	        quantity
	    )
	VALUES (
	        order_id,
	        book_id,
	        _price,
	        _discount,
	        _quantity
	    );
	END LOOP item_loop;
	SET ORDER_ID_OUT = order_id;
END;

---END create order procedure-----------------------------

DROP TRIGGER IF EXISTS update_order;

CREATE TRIGGER UPDATE_ORDER BEFORE UPDATE ON ORDERS 
FOR EACH ROW BEGIN 
	DECLARE _book_id VARCHAR(255);
	DECLARE _book_quantity INT;
	DECLARE _order_quantity INT;
	DECLARE _done INT DEFAULT FALSE;
	DECLARE _cursor CURSOR FOR (
	    SELECT
	        b.id as book_id,
	        b.quantity AS book_quantity,
	        ob.quantity AS order_quantity
	    FROM books AS b
	        JOIN orderbooks AS ob ON b.id = ob.book_id
	    WHERE
	        ob.order_id = old.id
	);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET _done = TRUE;
	OPEN _cursor;
	IF new.state = 'CONFIRM'
	and old.state = 'INIT' THEN read_loop:
	LOOP
	    FETCH _cursor INTO _book_id,
	    _book_quantity,
	    _order_quantity;
	IF _done THEN LEAVE read_loop;
	END IF;
	IF _book_quantity <= _order_quantity THEN SIGNAL SQLSTATE '45000'
	SET
	    MESSAGE_TEXT = 'Số lượng sản phẩm hiện không đủ!';
	END IF;
	UPDATE books
	SET
	    quantity = (
	        _book_quantity - _order_quantity
	    )
	WHERE books.id = _book_id;
	END LOOP;
	ELSEIF new.state = 'CANCEL'
	and old.state = 'CONFIRM' THEN read_loop:
	LOOP
	    FETCH _cursor INTO _book_id,
	    _book_quantity,
	    _order_quantity;
	IF _done THEN LEAVE read_loop;
	END IF;
	UPDATE books
	SET
	    quantity = (
	        _book_quantity + _order_quantity
	    )
	WHERE id = _book_id;
	END LOOP;
	END IF;
	CLOSE _cursor;
END; 

drop PROCEDURE if exists `CONFIRM_ORDER`;

/*  */

CREATE PROCEDURE CONFIRM_ORDER(IN _ORDER_ID VARCHAR
(36), IN _PROVINCE VARCHAR(255), IN _COUNTRY VARCHAR
(255), IN _DISTRICT VARCHAR(255), IN _WARDS VARCHAR
(255), IN _HOME VARCHAR(255)) BEGIN 
	DECLARE _ADDRESS_ID VARCHAR(36);
	DECLARE _STATE VARCHAR(255);
	DECLARE CONTINUE HANDLER FOR SQLSTATE '45000' ROLLBACK;
	START TRANSACTION;
	SELECT
	    address_id,
	    state INTO _ADDRESS_ID,
	    _STATE
	FROM ORDERS
	WHERE ID = _ORDER_ID;
	IF _STATE <> 'INIT' THEN SIGNAL SQLSTATE '45000'
	SET
	    MESSAGE_TEXT = 'Trạng thái của đơn hàng phải INIT mới có thể CONFIRM';
	END IF;
	UPDATE ADDRESS
	SET
	    PROVINCE = _PROVINCE,
	    DISTRICT = _DISTRICT,
	    WARDS = _WARDS,
	    COUNTRY = _COUNTRY,
	    HOME = _HOME
	WHERE ID = _ADDRESS_ID;
	UPDATE ORDERS SET STATE = 'CONFIRM' WHERE ID = _ORDER_ID;
END; 

call
    create_new_order(
        '742c7d8f-750f-11ed-b055-b445062d2ff3|742dfda0-750f-11ed-b055-b445062d2ff3',
        '3|14', 'f58d2683-7921-11ed-83a1-b445062d2ff3', @ORDER_ID
    );

select * from users;

select @ORDER_ID;

/* DROP FUNCTION IF EXISTS create_new_order; */
/* CREATE FUNCTION create_new_order (LIST_BOOK_ID VARCHAR(255), LIST_QUANTITY VARCHAR(255)) 
RETURNS varchar(36)
DETERMINISTIC
BEGIN
	DECLARE ORDER_ID VARCHAR(36) DEFAULT '';
	call create_new_order(LIST_BOOK_ID, LIST_QUANTITY, ORDER_ID);
	return ORDER_ID;
END; */

SELECT create_new_order('742c7d8f-750f-11ed-b055-b445062d2ff3|742dfda0-750f-11ed-b055-b445062d2ff3', '3|14');


select * from orders;

/* Need to throw warning */

call
    CONFIRM_ORDER(
        '4b5c169c-79fc-11ed-a4f0-b445062d2ff3',
        'Viet Nam',
        'Ho Chi Minh',
        'Thu Duc',
        'Linh Trung',
        '12/122'
    );

update orders
set state = 'CANCEL'
where
    id = '4b5c169c-79fc-11ed-a4f0-b445062d2ff3';

/* select * from books where quantity < 50; */

/* desc orders; */

/* select * from orders; */

/* select * from orderbooks; */

/* delete from orderbooks WHERE true; */

/* delete from orders where true; */

/* update books set quantity = 50 WHERE quantity < 50; */

/* SELECT
 SPLIT_STR(
 '742c7d8f-750f-11ed-b055-b445062d2ff3|742dfda0-750f-11ed-b055-b445062d2ff3',
 '|',
 @a
 ); */