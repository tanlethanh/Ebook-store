-- Active: 1670753632697@@127.0.0.1@3306@ebook_store

-- drop database if exists ebook_store;

-- create database ebook_store;

# discount must lte 1 and gte 0 use ebook_store;

create table
    Books (
        id varchar(36) primary key default (uuid()),
        name varchar(255) not null,
        price int not null,
        discount float not null default 0,
        current_price int,
        quantity int not null,
        rating_score float default 0.0,
        rating_count int default 0,
        policy varchar(255),
        author varchar(255),
        description varchar(255),
        state enum ('ENABLE', 'DISABLE') default 'ENABLE' not null,
        main_image_url varchar(255)
    );

create table
    BookImages (
        book_id varchar(36) not null,
        url varchar(255) not null,
        foreign key (book_id) references Books (id) on delete cascade on update cascade,
        primary key (book_id, url)
    );

create table
    Suppliers (
        id varchar(36) primary key default (uuid()),
        name varchar(255) not null,
        description varchar(255),
        ref_link varchar(255),
        created_date datetime default now(),
        updated_date datetime default now()
    );

# Relationship: Book is supplied by Supplier
alter table Books
add supplier_id varchar(36),
add
    constraint books_suppliers_fk foreign key (supplier_id) references Suppliers (id) on delete
set null on update cascade;

create table
    Categories (
        id varchar(36) primary key default (uuid()),
        name varchar(255)
    );

create table
    SpecificCategories (
        id varchar(36) default (uuid()),
        name varchar(255) not null,
        description varchar(255),
        category_id varchar(36) not null,
        constraint categories_fk foreign key (category_id) references Categories (id) on delete cascade on update cascade,
        unique (name, category_id),
        primary key (id, category_id)
    );

# Relationship: Book is in specific category (many* to many)
alter table Books
add
    column (
        specific_category_id varchar(36),
        category_id varchar(36)
    ),
add
    constraint specific_categories_fk foreign key (
        specific_category_id,
        category_id
    ) references SpecificCategories (id, category_id) on delete
set
    null # Warning when delete category
    on update cascade;

create table
    Users (
        id varchar(36) primary key default (uuid()),
        username varchar(255) not null unique,
        password varchar(255) not null,
        role enum ('ADMIN', 'CUSTOMER', 'MANAGER') not null,
        name varchar(255) not null,
        email varchar(255) not null unique,
        phone_number varchar(255) not null unique,
        birthday date,
        gender enum ('M', 'F', 'A'),
        # male, female, another
        created_date datetime default now(),
        updated_date datetime default now()
    );

create table
    Address (
        id varchar(36) primary key default (uuid()),
        province varchar(255) not null,
        district varchar(255) not null,
        wards varchar(255) not null,
        country varchar(255) not null,
        home varchar(255) not null,
        user_id varchar(36),
        constraint address_users_fk foreign key (user_id) references Users (id) on delete cascade on update cascade
    );

create table
    Orders (
        id varchar(36) primary key default (uuid()),
        init_date datetime not null default now(),
        begin_shipment_date datetime,
        received_date datetime,
        updated_date datetime default now(),
        state enum (
            'INIT',
            'CONFIRM',
            'SHIPPING',
            'DONE',
            'CANCEL'
        ) default 'INIT',
        payment_method enum ('ONLINE', 'OFFLINE'),
        payment_state enum ('NOT YET', 'DONE'),
        receiver_name varchar(255) not null,
        phone_number varchar(255) not null,
        note varchar(255),
        total_price int not null,
        total_discount int not null default 0,
        shipment_cost int not null default 50000,
        address_id varchar(36) not null unique,
        user_id varchar(36),
        constraint orders_address_fk foreign key (address_id) references Address (id) on delete restrict on update cascade,
        constraint orders_users_fk foreign key (user_id) references Users (id) on delete
        set
            null on update cascade
    );

################## warning
# Relationship: Order contains Book (many to many)
create table
    OrderBooks (
        order_id varchar(36),
        book_id varchar(36),
        quantity int not null,
        price int not null,
        discount float not null,
        constraint orderbooks_orders_fk foreign key (order_id) references Orders (id) on delete cascade on update cascade,
        constraint orderbooks_books_fk foreign key (book_id) references Books (id) on delete restrict # disable item or change quantity of book to 0
        on update cascade,
        primary key (order_id, book_id)
    );

create table
    Vouchers (
        id varchar(36) primary key default (uuid()),
        name varchar(255) not null,
        type enum ('SHIPMENT', 'PRODUCT') not null,
        total_quantity int not null,
        available_quantity int not null,
        base_price int not null,
        discount float not null,
        max_reduced_money int not null,
        valid_date datetime not null,
        created_date datetime not null default now(),
        updated_date datetime not null default now(),
        created_user_id varchar(36),
        foreign key (created_user_id) references Users (id) on delete
        set
            null on update cascade
    );

# Relationship: Voucher is applied in order
create table
    VoucherOrder (
        voucherId varchar(36) not null,
        orderId varchar(36) not null,
        foreign key (voucherId) references Vouchers (id) on delete restrict on update cascade,
        foreign key (orderId) references Orders (id) on delete cascade on update cascade,
        primary key (voucherId, orderId)
    );

create table
    Comments (
        id varchar(36) default (uuid()) primary key,
        content varchar(255),
        score int,
        created_date datetime not null default now(),
        updated_date datetime not null default now(),
        customer_bought bool default false,
        userId varchar(36) not null,
        bookId varchar(36) not null,
        root_comment_id varchar(36),
        constraint comments_users_fk foreign key (userId) references Users (id) on delete cascade on update cascade,
        constraint comments_books_fk foreign key (bookId) references Books (id) on delete cascade on update cascade
    );

alter table Comments
add
    constraint comments_comments_fk foreign key (root_comment_id) references Comments (id) on delete cascade on update cascade;

use ebook_store;

create table
    Carts (
        id varchar(36) default(uuid()) primary key,
        user_id varchar(36),
        Foreign Key (user_id) REFERENCES Users(id)
    );

create table
    CartItems (
        cart_id varchar(36),
        book_id varchar(36),
        quantity int not null,
        state enum('RELEASED', 'NOW') default('NOW'),
        constraint cartitems_carts_fk foreign key (cart_id) references Carts (id) on delete cascade on update cascade,
        constraint cartitems_books_fk foreign key (book_id) references Books (id) on delete cascade # disable item or change quantity of book to 0
        on update cascade,
        primary key (cart_id, book_id)
    );

alter table users
add
    column cart_id varchar(36),
add
    FOREIGN key (cart_id) REFERENCES carts(id);

alter table users
add
    column cart_id varchar(36),
add
    FOREIGN key (cart_id) REFERENCES carts(id);