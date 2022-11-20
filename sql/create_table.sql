drop database if exists ebook_store;
create database ebook_store;

use ebook_store;

# discount must lte 1 and gte 0
create table Book (
    id            varchar(36) primary key default (uuid()),
    price         int not null,
    discount      float not null default 0,
    policy        varchar(255),
    author        varchar(255),
    name          varchar(255) not null,
    description   varchar(255),
    quantity      int not null,
    rating        float,
    current_price int,
    state enum('ENABLE', 'DISABLE') default 'ENABLE' not null
);

create table TextBook (
    id varchar(36) primary key default (uuid()),
    foreign key (id) references Book(id)
        on delete cascade on update cascade
);

create table SeriesBook (
    id varchar(36) not null,
    series_name varchar(255),
    chapter int,
    description varchar(255),
    foreign key (id) references Book(id)
        on delete cascade on update cascade,
    primary key (id)
);

create table BookImage (
    book_id varchar(36) primary key,
    foreign key (book_id) references Book(id)
        on delete cascade on update cascade
);

create table Supplier (
    id          varchar(36) primary key default (uuid()),
    name        varchar(255) not null,
    description varchar(255),
    ref_link    varchar(255)
);

# Relationship: Book is supplied by Supplier
alter table Book
    add supplier_id varchar(36),
    add foreign key (supplier_id) references Supplier(id)
        on delete set null on update cascade;

create table Category (
    id          varchar(36) primary key default (uuid()),
    name        varchar(255)
);

create table SpecificCategory (
    id          varchar(36) default (uuid()),
    name        varchar(255),
    description varchar(255),
    category_id varchar(36) not null,
    foreign key (category_id) references Category(id)
        on delete cascade on update cascade,
    primary key (id, category_id)
);

# Relationship: Book is in specific category (many* to many)
alter table Book
add column (specific_category_id varchar(36), category_id varchar(36)),
add foreign key (specific_category_id, category_id)
    references SpecificCategory(id, category_id)
    on delete set null # Warning when delete category
    on update cascade;

create table Customer (
    id varchar(36) primary key default (uuid()),
    name varchar(255) not null,
    address varchar(255),
    phone_number varchar(255) not null unique,
    email varchar(255) not null unique
);

create table `Order` (
    id varchar(36) primary key default (uuid()),
    init_date datetime not null default now(),
    begin_shipment_date datetime,
    state enum('INIT', 'SHIPPING', 'DONE') default 'INIT',
#     shipment_state enum('IN PROGRESS', 'DONE'),
    current_location varchar(255),
    received_date datetime,
    payment_method enum('ONLINE', 'OFFLINE'),
    payment_state enum('NOT YET', 'DONE'),
    receiver_name varchar(255) not null,
    phone_number varchar(255) not null,
    address varchar(255) not null,
    note varchar(255),
    total_cost int not null,
    total_price int not null,
    total_discount int not null default 0
);

################## warning
# Relationship: Order contains Book (many to many)
create table OrderBook (
    order_id varchar(36),
    book_id varchar(36),
    quantity int not null,
    price int not null,
    discount float,
    foreign key (order_id) references `Order`(id)
        on delete cascade
        on update cascade,
    foreign key (book_id) references Book(id)
        on delete restrict # disable item or change quantity of book to 0
        on update cascade,
    primary key (order_id, book_id)
);

# Relationship Customer buy Order
alter table `Order`
    add customer_id varchar(36),
    add foreign key (customer_id) references Customer(id)
            on delete set null # data can use for statistic when delete customer
            on update cascade;

create table User (
    id varchar(36) primary key default (uuid()),
    username varchar(255) not null ,
    password varchar(255) not null default ('123456'),
    role enum('ADMIN', 'MANAGER', 'CUSTOMER') not null default 'CUSTOMER',
    created_date datetime not null default now(),
    updated_date datetime not null default now()
);

create table MemberCustomer (
    userId varchar(36),
    birthday date,
    accumulated_point int default 0,
    gender varchar(255),
    foreign key (userId) references User(id)
        on delete cascade on update cascade ,
    primary key (userId),
    customerId varchar(36) unique,
    # Relationship: Member customer is customer
    foreign key (customerId) references Customer(id)
        on delete cascade on update cascade
);

create table Admin (
    userId varchar(36),
    certificate varchar(255),
    foreign key (userId) references User(id)
        on delete cascade on update cascade,
    primary key (userId)
);

create table AdminTimeWorking (
    userId varchar(36),
    foreign key (userId) references Admin(userId)
        on delete cascade on update cascade ,
    primary key (userId),
    time_working datetime
);

create table Voucher (
    id varchar(36) primary key default (uuid()),
    name varchar(255) not null,
    type enum('SHIPMENT', 'PRODUCT') not null,
    total_quantity int not null,
    available_quantity int not null,
    base_price int not null,
    discount float not null,
    max_reduced_money int not null,
    valid_date datetime not null,
    created_date datetime not null,
    adminId varchar(36),
    foreign key (adminId) references Admin(userId) # Relationship: admin create voucher
        on delete set null on update cascade
);

# Relationship: Voucher is applied in order
create table VoucherOrder (
    voucherId varchar(36) not null,
    orderId varchar(36) not null,
    foreign key (voucherId) references Voucher(id)
        on delete cascade
        on update cascade,
    foreign key (orderId) references `Order`(id)
        on delete cascade
        on update cascade,
    primary key (voucherId, orderId)
);

create table Comment (
    id varchar(36) not null default (uuid()),
    content varchar(255),
    score int,
    created_date datetime not null default now(),
    updated_date datetime not null default now(),
    userId varchar(36) not null,
    orderId varchar(36) not null,
    foreign key (userId) references User(id)
        on delete cascade
        on update cascade,
    foreign key (orderId) references User(id)
        on delete cascade
        on update cascade,
    primary key (id, userId, orderId)
)
