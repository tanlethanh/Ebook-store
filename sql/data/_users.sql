use ebook_store;


create procedure insert_member_customer(
    in _username varchar(255),
    in _password varchar(255),
    in _name varchar(255),
    in _address varchar(255),
    in _phone_number varchar(255),
    in _email varchar(255),
    in _birthday date,
    in _gender varchar(255)
)
begin
    declare exit handler for sqlexception
        begin
            rollback;
        end;
    start transaction;
    insert into customers (name, address, phone_number, email)
    values (_name, _address, _phone_number, _email);
    select @customer_id := id from customers
    where name = _name
      and address = _address
      and phone_number = _phone_number
      and email = _email;
    insert into users (username, password) values (_username, _password);
    select @user_id := id from users where username = _username and password = _password;
    insert into membercustomers (userId, birthday, gender, customerId)
    values (@user_id, _birthday, _gender, @customer_id);
    commit;
end;

call insert_member_customer(
        'tanle',
        '123456',
        'Tan Le',
        'Viet Nam',
        '0949911677',
        'tanle@gmail.com',
        '2002-08-30',
        'nam'
    );

insert into Orders (id, begin_shipment_date, state, receiver_name, phone_number, address, total_cost, total_price)
values ('1', STR_TO_DATE('11-09-2022', '%d-%m-%Y'), 'SHIPPING', 'Huong', '0976851127', 'Quan 10', 100000, 100000);
insert into Orders (id, begin_shipment_date, state, receiver_name, phone_number, address, total_cost, total_price)
values ('2', STR_TO_DATE('11-09-2022', '%d-%m-%Y'), 'INIT', 'Tien', '0976843321', 'Quan 12', 300000, 300000);

-- Trigger
-- Không được xoá đơn hàng có trạng thái shipping
DROP TRIGGER IF EXISTS beforeRemoveOrder;
CREATE TRIGGER beforeRemoveOrder
    BEFORE DELETE
    ON Orders
    FOR EACH ROW
BEGIN
    DECLARE state VARCHAR(255);
    IF old.state = 'SHIPPING' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Cannot remove order that is being shipped!!';
    END IF;
END;
-- Test case
DELETE
FROM Orders
WHERE id = '1';

-- Tính toán lại rating khi có khách hàng để lại bình luận mới
DROP TRIGGER IF EXISTS calculateRating;
CREATE TRIGGER calculateRating
    AFTER INSERT
    ON Comments
    FOR EACH ROW
BEGIN
    DECLARE finalScore INT DEFAULT 0;
    DECLARE count INT DEFAULT 0;
    SELECT SUM(score) INTO finalScore FROM Comments WHERE id = NEW.bookId;
    SELECT COUNT(score) INTO count FROM Comments WHERE id = NEW.bookId;
    UPDATE Books
    SET rating = finalScore / count
    WHERE id = NEW.bookId;
END;
-- Test case


