-- Active: 1670753632697@@127.0.0.1@3306@ebook_store

use ebook_store;

drop PROCEDURE IF EXISTS INSERT_USER_WITH_CART;

CREATE PROCEDURE INSERT_USER_WITH_CART(IN _USERNAME 
VARCHAR(255), IN _PASSWORD VARCHAR(255), IN _ROLE 
ENUM('ADMIN', 'CUSTOMER', 'MANAGER'), IN _NAME VARCHAR
(255), IN _EMAIL VARCHAR(255), IN _PHONE_NUMBER VARCHAR
(255), IN _BIRTHDAY DATE, IN _GENDER ENUM('M', 'F'
, 'A')) BEGIN 
	DECLARE count_user int;
	Select count(*) into count_user
	from users
	WHERE username = _username;
	IF count_user <> 0 THEN Signal sqlstate '45000'
	SET
	    message_text = 'Tên tài khoản đã tồn tại';
	END IF;
	Select count(*) into count_user from users WHERE email = _email;
	IF count_user <> 0 THEN Signal sqlstate '45000'
	SET
	    message_text = 'Tài khoản này có email đã tồn tại';
	END IF;
	Select count(*) into count_user
	from users
	WHERE
	    phone_number = _phone_number;
	IF count_user <> 0 THEN Signal sqlstate '45000'
	SET
	    message_text = 'Tài khoản này có số điện thoại đã tồn tại';
	END IF;
	if(
	    regexp_like(
	        _phone_number,
	        '^[[:digit:]]{10}$'
	    ) = 0
	) then signal sqlstate '45000'
	set
	    message_text = "Số điện thoại không hợp lệ";
	end if;
	if(_email NOT LIKE '%_@__%.__%') then signal sqlstate '45000'
	set
	    message_text = "Email không hợp lệ";
	end if;
	INSERT INTO
	    users(
	        username,
	        password,
	        role,
	        name,
	        email,
	        phone_number,
	        birthday,
	        gender,
	        cart_id
	    )
	values (
	        _username,
	        _password,
	        _role,
	        _name,
	        _email,
	        _phone_number,
	        _birthday,
	        _gender, (uuid())
	    );
END; 

CREATE TRIGGER BEFORE_INSERT_USER BEFORE INSERT ON 
USERS FOR EACH ROW BEGIN 
	INSERT INTO carts(id) values (new.cart_id);
END; 

-- Test case