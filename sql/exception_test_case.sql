-- Active: 1670753632697@@127.0.0.1@3306@ebook_store

use ebook_store;

--------------------------------------------------------------------------------------------------------

------USER DATA-----------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------

--Normal insert - test procedure validate when insert -  test trigger before insert, insert cart id for user

call
    insert_user_with_cart(
        'duplicate_username',
        'normal_password',
        'CUSTOMER',
        'normal_name',
        'duplicate_email@gmail.com',
        '0123456789',
        --10 digit
        '2022-12-23',
        'M'
    );

-- duplicate username

call
    insert_user_with_cart(
        'duplicate_username',
        '123',
        'CUSTOMER',
        'Hâng Hưng Trai',
        'duplicate_username@gmail.com',
        '1123456789',
        --10 digit
        '2022-12-23',
        'M'
    );

-- duplicate email

call
    insert_user_with_cart(
        'difference_email',
        '123',
        'CUSTOMER',
        'Đẹp Hưng Trai',
        'duplicate_email@gmail.com',
        '2123456789',
        --10 digit
        '2022-12-23',
        'M'
    );

-- duplicate phone number

call
    insert_user_with_cart(
        'difference_phone_number',
        '123',
        'CUSTOMER',
        'Đẹp Hưng Trai',
        'difference_phone_number@gmail.com',
        '0123456789',
        --10 digit
        '2022-12-23',
        'M'
    );

-- NOT email format

call
    insert_user_with_cart(
        'wrong_email_format',
        '123',
        'CUSTOMER',
        'Đẹp Hưng Trai',
        'wrongemailformat@ppprovipppp',
        '3123456789',
        --10 digit
        '2022-12-23',
        'M'
    );

-- NOT phone format

call
    insert_user_with_cart(
        'wrong_phone_format',
        '123',
        'CUSTOMER',
        'Đẹp Hưng Trai',
        'phone_format@pppro.vipppp',
        '1234567899999',
        --10 digit
        '2022-12-23',
        'M'
    );

--------------------------------------------------------------------------------------------------------

------CART DATA-----------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------

-- MUST fix book id (auto generate randomly different from each time)

-- test trigger signal many case of message error

--insert a cart

insert into carts (id)
VALUES (
        '9b0d2f5c-7924-11ed-83a1-b445062d2ff3'
    );

-- NOTE for testcase below

-- Click 1 times -> normal insert to cartitems

-- Click 2 times -> SIGNAL DUPLICATE message -> test luon cho nay nha

-- There're 03 different books to test this case

-- Book 1

insert into
    cartitems (book_id, cart_id, quantity)
VALUES (
        '25eae45f-7a31-11ed-b916-18dbf24df9d9',
        '9b0d2f5c-7924-11ed-83a1-b445062d2ff3',
        10
    );

-- Book 2

insert into
    cartitems (book_id, cart_id, quantity)
VALUES (
        '25eb2a55-7a31-11ed-b916-18dbf24df9d9',
        '9b0d2f5c-7924-11ed-83a1-b445062d2ff3',
        10
    );

-- Book 3

insert into
    cartitems (book_id, cart_id, quantity)
VALUES (
        '25eb7781-7a31-11ed-b916-18dbf24df9d9',
        '9b0d2f5c-7924-11ed-83a1-b445062d2ff3',
        10
    );

-- NOT exist the BOOK added to the CART

insert into
    cartitems (book_id, cart_id, quantity)
VALUES (
        'cuu_tuii-troi-oi11-b916-18dbf24df9d9',
        '9b0d2f5c-7924-11ed-83a1-b445062d2ff3',
        10
    );

-- Add quantity more over BOOK quantity

insert into
    cartitems (book_id, cart_id, quantity)
VALUES (
        '25ef542d-7a31-11ed-b916-18dbf24df9d9',
        '9b0d2f5c-7924-11ed-83a1-b445062d2ff3',
        500
    );

--------------------------------------------------------------------------------------------------------

------ORDER DATA----------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------

-- test create order -- syntax = list_book_id, list_book_quantity

call
    create_new_order(
        'aaaaaca3-7a31-11ed-b916-18dbf24df9d9|25fb7120-7a31-11ed-b916-18dbf24df9d9|aaaaaa',
        '10|10'
    );