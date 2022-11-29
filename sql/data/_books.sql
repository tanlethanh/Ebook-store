use ebook_store;

drop procedure insert_book_with_main_image;
create procedure insert_book_with_main_image(in _name varchar(255),
                                             in _price int,
                                             in _discount float,
                                             in _quantity int,
                                             in _category varchar(255),
                                             in _image_url varchar(255))
begin
    select id, category_id
    into @spec_id, @cate_id
    from specificcategories
    where specificcategories.name = _category;
    insert into books (name, price, discount, quantity, specific_category_id, category_id, main_image_url)
    values (_name, _price, _discount, _quantity, @spec_id, @cate_id, _image_url);
end;

call insert_book_with_main_image(
        'Nhà Giả Kim (Tái Bản 2020)',
        55000,
        0.31,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_36793.jpg'
    );

call insert_book_with_main_image(
        'Cây Cam Ngọt Của Tôi',
        75000,
        0.31,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_217480.jpg'
    );

call insert_book_with_main_image(
        'Tiểu Thuyết Chuyển Thể - Thanh Gươm Diệt Quỷ: Câu Chuyện Về Tình Anh Em Và Đội Diệt Quỷ - Tặng Kèm OBI',
        46000,
        0.16,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/t/i/tieu-thuyet-chuyen-the---thanh-guom-diet-quy---cau-chuyen-ve-tinh-anh-em-va-doi-diet-quy-obi.jpg');
call insert_book_with_main_image(
        'Bước Chậm Lại Giữa Thế Gian Vội Vã (Tái Bản 2018)',
        59000,
        0.31,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/b/u/buoc_cham_lai_giua_the_gian_voi_va.u335.d20160817.t102115.612356.jpg');

call insert_book_with_main_image(
        'Ra Bờ Suối Ngắm Hoa Kèn Hồng - Tặng Kèm Bookmark Bồi Hai Mặt + Thiệp Trái Tim In Bài Thơ Của Tác Giả',
        116000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/6/0/600ra-bo-suoi---bm_1.jpg');

call insert_book_with_main_image(
        'Cho Tôi Xin Một Vé Đi Tuổi Thơ (Bìa Mềm) (Tái Bản 2018)',
        60000,
        0.25,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_180164_1_43_1_57_1_4_1_2_1_210_1_29_1_98_1_25_1_21_1_5_1_3_1_18_1_18_1_45_1_26_1_32_1_14_1_1233.jpg');

call insert_book_with_main_image(
        'Tôi Là Bêtô (Tái Bản 2018)',
        68000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_180164_1_43_1_57_1_4_1_2_1_210_1_29_1_98_1_25_1_21_1_5_1_3_1_18_1_18_1_45_1_26_1_32_1_14_1_1236.jpg');

call insert_book_with_main_image(
        'Rừng Nauy (Tái Bản 2021)',
        120000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_240307.jpg');

call insert_book_with_main_image(
        'Tôi Thấy Hoa Vàng Trên Cỏ Xanh (Bản In Mới - 2018)',
        85000,
        0.32,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_180164_1_43_1_57_1_4_1_2_1_210_1_29_1_98_1_25_1_21_1_5_1_3_1_18_1_18_1_45_1_26_1_32_1_14_1_2199.jpg');

call insert_book_with_main_image(
        'Làm Bạn Với Bầu Trời - Tặng Kèm Khung Hình Xinh Xắn',
        88000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/u/n/untitled-2_44.jpg');

call insert_book_with_main_image(
        'Con Chim Xanh Biếc Bay Về - Tặng Kèm 6 Postcard',
        110000,
        0.27,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/b/i/biamem.jpg');

call insert_book_with_main_image(
        'Có Hai Con Mèo Ngồi Bên Cửa Sổ (Tái Bản 2018)',
        68000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/c/o/cohaiconmeobencuasotaiban2018_1.jpg');

call insert_book_with_main_image(
        'Dấu Chân Trên Cát (Tái Bản 2020)',
        118000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_12629_1.jpg');

call insert_book_with_main_image(
        '999 Lá Thư Gửi Cho Chính Mình - Mong Bạn Trở Thành Phiên Bản Hoàn Hảo Nhất (Tập 1) - Tái Bản 2021',
        103000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/9/9/999lathu-taibbb1_2.jpg');

call insert_book_with_main_image(
        'Bí Mật Của Naoko',
        86000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_9655.jpg');

call insert_book_with_main_image(
        'Vừa Nhắm Mắt Vừa Mở Cửa Số (Tái Bản 2022)',
        60000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/8/9/8934974176213.jpg');

call insert_book_with_main_image(
        'Ngày Xưa Có Một Chuyện Tình (Tái Bản 2019)',
        100000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_29716.jpg');

call insert_book_with_main_image(
        'Số Đỏ',
        44000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_220968.jpg');

call insert_book_with_main_image(
        'Cảm Ơn Người Lớn (Bìa Mềm)',
        88000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/c/a/cam_on_nguoi_lon_bia_mem_xp.jpg');

call insert_book_with_main_image(
        'Tìm Em Nơi Anh - Find Me',
        92000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_225272.jpg');

call insert_book_with_main_image(
        'Chuyện Con Mèo Và Con Chuột Bạn Thân Của Nó (Tái Bản 2019)',
        31000,
        0.21,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_181813.jpg');

call insert_book_with_main_image(
        'Gọi Em Bằng Tên Anh',
        78000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/g/o/goiembangtenanh.jpg');

call insert_book_with_main_image(
        'Ngàn Mặt Trời Rực Rỡ (Tái Bản 2019)',
        104000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_181761.jpg');

call insert_book_with_main_image(
        'Thượng Dương',
        86000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_216250.jpg');
