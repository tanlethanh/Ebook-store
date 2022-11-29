use ebook_store;


INSERT INTO categories (name)
values ('VĂN HỌC'),
       ('KINH TẾ'),
       ('TÂM LÝ - KĨ NĂNG SỐNG'),
       ('NUÔI DẠY CON'),
       ('SÁCH THIẾU NHI'),
       ('TIỂU SỬ - HỒI KÝ'),
       ('GIÁO KHOA - THAM KHẢO'),
       ('SÁCH HỌC NGOẠI NGỮ');

insert into specificcategories (name, category_id)
values ('Tiểu Thuyết', (select id from categories where categories.name = 'VĂN HỌC')),
       ('Truyện Ngắn - Tản Văn', (select id from categories where categories.name = 'VĂN HỌC')),
       ('Light Novel', (select id from categories where categories.name = 'VĂN HỌC')),
       ('Ngôn Tình', (select id from categories where categories.name = 'VĂN HỌC'));

insert into specificcategories (name, category_id)
values ('Nhân Vật - Bài Học Kinh Doanh', (select id from categories where categories.name = 'KINH TẾ')),
       ('Quản Trị - Lãnh Đạo', (select id from categories where categories.name = 'KINH TẾ')),
       ('Marketing - Bán Hàng', (select id from categories where categories.name = 'KINH TẾ')),
       ('Phân Tích Kinh Tế', (select id from categories where categories.name = 'KINH TẾ'));

insert into specificcategories (name, category_id)
values (('Kỹ Năng Sống'), (select id from categories where categories.name = 'TÂM LÝ - KĨ NĂNG SỐNG')),
       (('Rèn Luyện Nhân Cách'), (select id from categories where categories.name = 'TÂM LÝ - KĨ NĂNG SỐNG')),
       (('Tâm Lý'), (select id from categories where categories.name = 'TÂM LÝ - KĨ NĂNG SỐNG')),
       (('Sách Cho Tuổi Mới Lớn'), (select id
                                    from categories
                                    where categories.name = 'TÂM LÝ - KĨ NĂNG SỐNG'));

insert into specificcategories (name, category_id)
values ('Cẩm Nang Làm Cha Mẹ', (select id from categories where categories.name = 'NUÔI DẠY CON')),
       ('Phương Pháp Giáo Dục Trẻ Các Nước', (select id from categories where categories.name = 'NUÔI DẠY CON')),
       ('Phát Triển Trí Tuệ Cho Trẻ', (select id from categories where categories.name = 'NUÔI DẠY CON')),
       ('Phát Triển Kỹ Năng Cho Trẻ', (select id from categories where categories.name = 'NUÔI DẠY CON'));

insert into specificcategories (name, category_id)
values ('Manga - Comic', (select id from categories where categories.name = 'SÁCH THIẾU NHI')),
       ('Kiến Thức Bách Khoa', (select id from categories where categories.name = 'SÁCH THIẾU NHI')),
       ('Sách Tranh Kỹ Năng Sống Cho Trẻ', (select id from categories where categories.name = 'SÁCH THIẾU NHI')),
       ('Vừa Học - Vừa Học Vừa Chơi Với Trẻ', (select id from categories where categories.name = 'SÁCH THIẾU NHI'));

insert into specificcategories (name, category_id)
values ('Câu Chuyện Cuộc Đời', (select id from categories where categories.name = 'TIỂU SỬ - HỒI KÝ')),
       ('Chính Trị', (select id from categories where categories.name = 'TIỂU SỬ - HỒI KÝ')),
       ('Kinh Tế', (select id from categories where categories.name = 'TIỂU SỬ - HỒI KÝ')),
       ('Nghệ Thuật - Giải Trí', (select id from categories where categories.name = 'TIỂU SỬ - HỒI KÝ'));

insert into specificcategories (name, category_id)
values ('Sách Giáo Khoa', (select id from categories where categories.name = 'GIÁO KHOA - THAM KHẢO')),
       ('Sách Tham Khảo', (select id from categories where categories.name = 'GIÁO KHOA - THAM KHẢO')),
       ('Luyện thi ĐH, CĐ', (select id from categories where categories.name = 'GIÁO KHOA - THAM KHẢO')),
       ('Mẫu Giáo', (select id from categories where categories.name = 'GIÁO KHOA - THAM KHẢO'));

insert into specificcategories (name, category_id)
values ('Tiếng Anh', (select id from categories where categories.name = 'SÁCH HỌC NGOẠI NGỮ')),
       ('Tiếng Nhật', (select id from categories where categories.name = 'SÁCH HỌC NGOẠI NGỮ')),
       ('Tiếng Hoa', (select id from categories where categories.name = 'SÁCH HỌC NGOẠI NGỮ')),
       ('Tiếng Hàn', (select id from categories where categories.name = 'SÁCH HỌC NGOẠI NGỮ'));

