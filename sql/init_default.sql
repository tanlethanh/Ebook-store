-- Active: 1670753632697@@127.0.0.1@3306@ebook_store
insert into carts (id)
VALUES (
        '9b0d2f5c-7924-11ed-83a1-b445062d2ff3'
    );

insert into
    users (
        id,
        username,
        password,
        role,
        name,
        email,
        phone_number,
    )
VALUES (
        'f58d2683-7921-11ed-83a1-b445062d2ff3',
        'tanle',
        '123456',
        'CUSTOMER',
        'Tan Le ',
        'tan@gmail.com',
        '0337229803',
        'd82c74f5-7927-11ed-83a1-b445062d2ff3'
    ), (
        'f58e2784-7921-11ed-83a1-b445062d2ff3',
        'admin',
        '123456',
        'ADMIN',
        'Admin',
        'admin@gmail.com',
        '000',
        NULL
    );