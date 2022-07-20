create table item
(
    id          int auto_increment
        primary key,
    title       varchar(255)   default ''   not null,
    price       decimal(64, 2) default 0.00 not null,
    description varchar(500)   default ''   not null,
    sales       int            default 0    not null,
    img_url     varchar(5000)  default ''   not null
)
    collate = utf8_bin;

INSERT INTO miaosha.item (id, title, price, description, sales, img_url) VALUES (1, 'iphone99', 800.00, '最好用的iphone', 5, 'https://img0.baidu.com/it/u=3092369368,1067107050&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1658422800&t=8b85c8ccd3e4fedd14eb6f34d8031ea2');
INSERT INTO miaosha.item (id, title, price, description, sales, img_url) VALUES (2, 'iphone99', 800.00, '最好用的iphone', 0, 'https://img0.baidu.com/it/u=3092369368,1067107050&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1658422800&t=8b85c8ccd3e4fedd14eb6f34d8031ea2');
INSERT INTO miaosha.item (id, title, price, description, sales, img_url) VALUES (3, 'iphone8', 200.00, '第二好用的iphone', 3, 'https://img0.baidu.com/it/u=3092369368,1067107050&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1658422800&t=8b85c8ccd3e4fedd14eb6f34d8031ea2');
INSERT INTO miaosha.item (id, title, price, description, sales, img_url) VALUES (4, 'iphone8', 200.00, '第二好用的iphone', 0, 'https://img0.baidu.com/it/u=3092369368,1067107050&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1658422800&t=8b85c8ccd3e4fedd14eb6f34d8031ea2');
INSERT INTO miaosha.item (id, title, price, description, sales, img_url) VALUES (9, 'huawei1', 800.00, 'huawei', 0, 'https://img0.baidu.com/it/u=3092369368,1067107050&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1658422800&t=8b85c8ccd3e4fedd14eb6f34d8031ea2');

create table item_stock
(
    id      int auto_increment
        primary key,
    stock   int default 0 not null,
    item_id int           not null
)
    collate = utf8_bin;

INSERT INTO miaosha.item_stock (id, stock, item_id) VALUES (9, 94, 1);
INSERT INTO miaosha.item_stock (id, stock, item_id) VALUES (10, 100, 2);
INSERT INTO miaosha.item_stock (id, stock, item_id) VALUES (11, 97, 3);
INSERT INTO miaosha.item_stock (id, stock, item_id) VALUES (12, 300, 4);
INSERT INTO miaosha.item_stock (id, stock, item_id) VALUES (17, 100, 9);

create table order_info
(
    id          varchar(32)                 not null
        primary key,
    user_id     int            default 0    not null,
    item_id     int            default 0    not null,
    item_price  decimal(10, 2) default 0.00 not null,
    amount      int            default 0    not null,
    order_price decimal(40, 2) default 0.00 not null,
    promo_id    int            default 0    not null
)
    collate = utf8_bin;

INSERT INTO miaosha.order_info (id, user_id, item_id, item_price, amount, order_price, promo_id) VALUES ('2019080200000000', 40, 1, 23.00, 1, 23.00, 1);
INSERT INTO miaosha.order_info (id, user_id, item_id, item_price, amount, order_price, promo_id) VALUES ('2019080200000100', 40, 1, 23.00, 1, 23.00, 1);
INSERT INTO miaosha.order_info (id, user_id, item_id, item_price, amount, order_price, promo_id) VALUES ('2019080200000200', 40, 1, 23.00, 1, 23.00, 1);
INSERT INTO miaosha.order_info (id, user_id, item_id, item_price, amount, order_price, promo_id) VALUES ('2019080200000300', 40, 3, 200.00, 1, 200.00, 0);
INSERT INTO miaosha.order_info (id, user_id, item_id, item_price, amount, order_price, promo_id) VALUES ('2019080200000400', 40, 3, 200.00, 1, 200.00, 0);
INSERT INTO miaosha.order_info (id, user_id, item_id, item_price, amount, order_price, promo_id) VALUES ('2019080200000500', 40, 3, 200.00, 1, 200.00, 0);
INSERT INTO miaosha.order_info (id, user_id, item_id, item_price, amount, order_price, promo_id) VALUES ('2022071900000600', 60, 1, 800.00, 1, 800.00, 0);
INSERT INTO miaosha.order_info (id, user_id, item_id, item_price, amount, order_price, promo_id) VALUES ('2022071900000700', 60, 1, 800.00, 1, 800.00, 0);
INSERT INTO miaosha.order_info (id, user_id, item_id, item_price, amount, order_price, promo_id) VALUES ('2022072000000800', 60, 1, 23.00, 1, 23.00, 1);

create table promo
(
    id               int auto_increment
        primary key,
    promo_name       varchar(255)   default ''                    not null,
    start_date       datetime       default '0000-00-00 00:00:00' not null,
    end_date         datetime       default '0000-00-00 00:00:00' not null,
    item_id          int            default 0                     not null,
    promo_item_price decimal(10, 2) default 0.00                  not null
)
    collate = utf8_bin;

INSERT INTO miaosha.promo (id, promo_name, start_date, end_date, item_id, promo_item_price) VALUES (1, 'iphone大减价', '2022-07-20 14:28:59', '2022-08-09 19:55:52', 1, 23.00);
INSERT INTO miaosha.promo (id, promo_name, start_date, end_date, item_id, promo_item_price) VALUES (2, 'iphone8大减价', '2019-08-27 20:17:17', '2019-09-05 20:18:18', 3, 3.00);

create table sequence_info
(
    name          varchar(255)  not null
        primary key,
    current_value int default 0 not null,
    step          int default 0 not null
)
    collate = utf8_bin;

INSERT INTO miaosha.sequence_info (name, current_value, step) VALUES ('order_info', 9, 1);

create table user_info
(
    id             int auto_increment
        primary key,
    name           varchar(64) default '' not null,
    gender         tinyint     default 0  not null comment '1代表男性
',
    age            int         default 0  not null,
    telphone       varchar(64) default '' not null,
    regisit_mode   varchar(64) default '' not null comment '//byphone,bywechat,byalipay,',
    third_party_id int         default 0  not null,
    constraint telphone_unique_index
        unique (telphone)
)
    collate = utf8_bin;

INSERT INTO miaosha.user_info (id, name, gender, age, telphone, regisit_mode, third_party_id) VALUES (40, '1', 1, 1, '123', 'byphone', 0);
INSERT INTO miaosha.user_info (id, name, gender, age, telphone, regisit_mode, third_party_id) VALUES (52, '1', 1, 1, '111111', 'byphone', 0);
INSERT INTO miaosha.user_info (id, name, gender, age, telphone, regisit_mode, third_party_id) VALUES (53, '1', 1, 11111111, '11', 'byphone', 0);
INSERT INTO miaosha.user_info (id, name, gender, age, telphone, regisit_mode, third_party_id) VALUES (55, '1', 1, 1, '111', 'byphone', 0);
INSERT INTO miaosha.user_info (id, name, gender, age, telphone, regisit_mode, third_party_id) VALUES (60, 'c', 1, 1, '12343567', 'byphone', 0);


create table user_password
(
    id              int auto_increment
        primary key,
    encrpt_password varchar(128) default '' not null,
    user_id         int          default 0  not null
)
    collate = utf8_bin;

create index use_id
    on user_password (user_id);

INSERT INTO miaosha.user_password (id, encrpt_password, user_id) VALUES (18, 'ICy5YqxZB1uWSwcVLSNLcA==', 40);
INSERT INTO miaosha.user_password (id, encrpt_password, user_id) VALUES (19, 'xMpCOKC5I4INzFCab3WEmw==', 0);
INSERT INTO miaosha.user_password (id, encrpt_password, user_id) VALUES (20, 'xMpCOKC5I4INzFCab3WEmw==', 0);
INSERT INTO miaosha.user_password (id, encrpt_password, user_id) VALUES (21, 'ICy5YqxZB1uWSwcVLSNLcA==', 0);
INSERT INTO miaosha.user_password (id, encrpt_password, user_id) VALUES (22, 'xMpCOKC5I4INzFCab3WEmw==', 52);
INSERT INTO miaosha.user_password (id, encrpt_password, user_id) VALUES (23, 'xMpCOKC5I4INzFCab3WEmw==', 53);
INSERT INTO miaosha.user_password (id, encrpt_password, user_id) VALUES (24, 'xMpCOKC5I4INzFCab3WEmw==', 55);
INSERT INTO miaosha.user_password (id, encrpt_password, user_id) VALUES (28, 'xMpCOKC5I4INzFCab3WEmw==', 60);