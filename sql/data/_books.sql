-- Active: 1670753632697@@127.0.0.1@3306@ebook_store
use ebook_store;

-- drop procedure insert_book_with_main_image;

CREATE PROCEDURE INSERT_BOOK_WITH_MAIN_IMAGE(IN _NAME 
VARCHAR(255), IN _PRICE INT, IN _DISCOUNT FLOAT, IN 
_QUANTITY INT, IN _CATEGORY VARCHAR(255), IN _IMAGE_URL 
VARCHAR(255)) BEGIN 
	select
	    id,
	    category_id into @spec_id,
	    @cate_id
	from specificcategories
	where
	    specificcategories.name = _category;
	insert into
	    books (
	        name,
	        price,
	        discount,
	        quantity,
	        specific_category_id,
	        category_id,
	        main_image_url
	    )
	values (
	        _name,
	        _price,
	        _discount,
	        _quantity,
	        @spec_id,
	        @cate_id,
	        _image_url
	    );
END; 

call
    insert_book_with_main_image(
        'Nhà Giả Kim (Tái Bản 2020)',
        55000,
        0.31,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_36793.jpg'
    );

call
    insert_book_with_main_image(
        'Cây Cam Ngọt Của Tôi',
        75000,
        0.31,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_217480.jpg'
    );

call
    insert_book_with_main_image(
        'Tiểu Thuyết Chuyển Thể - Thanh Gươm Diệt Quỷ: Câu Chuyện Về Tình Anh Em Và Đội Diệt Quỷ - Tặng Kèm OBI',
        46000,
        0.16,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/t/i/tieu-thuyet-chuyen-the---thanh-guom-diet-quy---cau-chuyen-ve-tinh-anh-em-va-doi-diet-quy-obi.jpg'
    );

call
    insert_book_with_main_image(
        'Bước Chậm Lại Giữa Thế Gian Vội Vã (Tái Bản 2018)',
        59000,
        0.31,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/b/u/buoc_cham_lai_giua_the_gian_voi_va.u335.d20160817.t102115.612356.jpg'
    );

call
    insert_book_with_main_image(
        'Ra Bờ Suối Ngắm Hoa Kèn Hồng - Tặng Kèm Bookmark Bồi Hai Mặt + Thiệp Trái Tim In Bài Thơ Của Tác Giả',
        116000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/6/0/600ra-bo-suoi---bm_1.jpg'
    );

call
    insert_book_with_main_image(
        'Cho Tôi Xin Một Vé Đi Tuổi Thơ (Bìa Mềm) (Tái Bản 2018)',
        60000,
        0.25,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_180164_1_43_1_57_1_4_1_2_1_210_1_29_1_98_1_25_1_21_1_5_1_3_1_18_1_18_1_45_1_26_1_32_1_14_1_1233.jpg'
    );

call
    insert_book_with_main_image(
        'Tôi Là Bêtô (Tái Bản 2018)',
        68000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_180164_1_43_1_57_1_4_1_2_1_210_1_29_1_98_1_25_1_21_1_5_1_3_1_18_1_18_1_45_1_26_1_32_1_14_1_1236.jpg'
    );

call
    insert_book_with_main_image(
        'Rừng Nauy (Tái Bản 2021)',
        120000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_240307.jpg'
    );

call
    insert_book_with_main_image(
        'Tôi Thấy Hoa Vàng Trên Cỏ Xanh (Bản In Mới - 2018)',
        85000,
        0.32,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_180164_1_43_1_57_1_4_1_2_1_210_1_29_1_98_1_25_1_21_1_5_1_3_1_18_1_18_1_45_1_26_1_32_1_14_1_2199.jpg'
    );

call
    insert_book_with_main_image(
        'Làm Bạn Với Bầu Trời - Tặng Kèm Khung Hình Xinh Xắn',
        88000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/u/n/untitled-2_44.jpg'
    );

call
    insert_book_with_main_image(
        'Con Chim Xanh Biếc Bay Về - Tặng Kèm 6 Postcard',
        110000,
        0.27,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/b/i/biamem.jpg'
    );

call
    insert_book_with_main_image(
        'Có Hai Con Mèo Ngồi Bên Cửa Sổ (Tái Bản 2018)',
        68000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/c/o/cohaiconmeobencuasotaiban2018_1.jpg'
    );

call
    insert_book_with_main_image(
        'Dấu Chân Trên Cát (Tái Bản 2020)',
        118000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_12629_1.jpg'
    );

call
    insert_book_with_main_image(
        '999 Lá Thư Gửi Cho Chính Mình - Mong Bạn Trở Thành Phiên Bản Hoàn Hảo Nhất (Tập 1) - Tái Bản 2021',
        103000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/9/9/999lathu-taibbb1_2.jpg'
    );

call
    insert_book_with_main_image(
        'Bí Mật Của Naoko',
        86000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_9655.jpg'
    );

call
    insert_book_with_main_image(
        'Vừa Nhắm Mắt Vừa Mở Cửa Số (Tái Bản 2022)',
        60000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/8/9/8934974176213.jpg'
    );

call
    insert_book_with_main_image(
        'Ngày Xưa Có Một Chuyện Tình (Tái Bản 2019)',
        100000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_29716.jpg'
    );

call
    insert_book_with_main_image(
        'Số Đỏ',
        44000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_220968.jpg'
    );

call
    insert_book_with_main_image(
        'Cảm Ơn Người Lớn (Bìa Mềm)',
        88000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/c/a/cam_on_nguoi_lon_bia_mem_xp.jpg'
    );

call
    insert_book_with_main_image(
        'Tìm Em Nơi Anh - Find Me',
        92000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_225272.jpg'
    );

call
    insert_book_with_main_image(
        'Chuyện Con Mèo Và Con Chuột Bạn Thân Của Nó (Tái Bản 2019)',
        31000,
        0.21,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_181813.jpg'
    );

call
    insert_book_with_main_image(
        'Gọi Em Bằng Tên Anh',
        78000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/g/o/goiembangtenanh.jpg'
    );

call
    insert_book_with_main_image(
        'Ngàn Mặt Trời Rực Rỡ (Tái Bản 2019)',
        104000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_181761.jpg'
    );

call
    insert_book_with_main_image(
        'Thượng Dương',
        86000,
        0.20,
        50,
        'Tiểu Thuyết',
        'https://cdn0.fahasa.com/media/catalog/product/i/m/image_216250.jpg'
    );

call
    insert_book_with_main_image(
        "name Từ Điển Tiếng “Em” - Tái Bản 2021",
        48000,
        0.30,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/b/i/bia_tudientiengem-_1_.jpg"
    );

call
    insert_book_with_main_image(
        "name Những Đêm Không Ngủ Những Ngày Chậm Trôi",
        67940,
        0.21,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/i/m/image_227604.jpg"
    );

call
    insert_book_with_main_image(
        "name Chuyện Kể Rằng Có Nàng Và Tôi",
        42480,
        0.41,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/b/i/bia_chuyen-ke-rang-co-nang-va-toi_final.jpg"
    );

call
    insert_book_with_main_image(
        "name Có Một Ngày, Bố Mẹ Sẽ Già Đi",
        75840,
        0.21,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/c/o/co-mot-ngay-bo-me-se-gia-di.jpg"
    );

call
    insert_book_with_main_image(
        "name Vui Vẻ Không Quạu Nha (Tái Bản 2021)",
        55000,
        0.20,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_33312_2.jpg"
    );

call
    insert_book_with_main_image(
        "name Vui Vẻ Không Quạu Nha 2 - Một Cuốn Sách Buồn… Cười",
        63000,
        0.20,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/8/9/8935325000157.jpg"
    );

call
    insert_book_with_main_image(
        "name Tâm An Ắt Bình An",
        72680,
        0.21,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/t/a/tam-an-at-binh-an.jpg"
    );

call
    insert_book_with_main_image(
        "name Màu Nhạt Nắng",
        119000,
        0.20,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/9/7/9786043451993.jpg"
    );

call
    insert_book_with_main_image(
        "name Dear, Darling - Tặng Kèm Postcard",
        52000,
        0.41,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/8/9/8935325004896_1.jpg"
    );

call
    insert_book_with_main_image(
        "name Chúng Ta Rồi Sẽ Hạnh Phúc, Theo Những Cách Khác Nhau",
        67940,
        0.21,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/1/3/139990755_1302883240068333_3844579474690419303_n.jpg"
    );

call
    insert_book_with_main_image(
        "name Hay Chúng Mình Đừng Hứa Hẹn Gì Nhau",
        92000,
        0.20,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/g/t/gt_hay-ch_ng-m_nh-_ng-h_a-h_n-g_-nhaubia1600.jpg"
    );

call
    insert_book_with_main_image(
        "name Hẹn Nhau Phía Sau Tan Vỡ",
        67940,
        0.21,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/b/i/bia_hen-nhau-sau-tan-vo_2.jpg"
    );

call
    insert_book_with_main_image(
        "name Phụ Nữ Hiểu Biết Sẽ Có Cuộc Sống Đẳng Cấp Hơn",
        95000,
        0.20,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/p/h/ph_-n_-hi_u-bi_t-s_-c_-cu_c-s_ng-_ng-c_p-h_n---b_a.jpg"
    );

call
    insert_book_with_main_image(
        "name Chuyện ICU - Khi Thiên Thần Nhiễm Bệnh",
        95000,
        0.20,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/g/i/gioi-thieu-sach-dr-wynn-4.jpg"
    );

call
    insert_book_with_main_image(
        "name Hai Mặt Của Gia Đình",
        78000,
        0.20,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_31258.jpg"
    );

call
    insert_book_with_main_image(
        "name Drama Nuôi Tôi Lớn Loài Người Dạy Tôi Khôn",
        79000,
        0.20,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/b/o/boitoi_infinal-_1__3.jpg"
    );

call
    insert_book_with_main_image(
        "name Lì Quá Để Nói Quài",
        61620,
        0.21,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/9/7/9786043556797.jpg"
    );

call
    insert_book_with_main_image(
        "name Đừng Nhạt Nữa",
        75840,
        0.21,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/i/m/image_226024.jpg"
    );

call
    insert_book_with_main_image(
        "name Thế Giới Này Âm Thầm Yêu Em",
        103000,
        0.20,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/b/i/bia-1_the-gioy-am-tham-yeu-em.jpg"
    );

call
    insert_book_with_main_image(
        "name Em - Liêu Hà Trinh (Tái Bản - Bìa Cứng)",
        95000,
        0.20,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/b/i/bia1-em_2.jpg"
    );

call
    insert_book_with_main_image(
        "name Mình Phải Sống Như Biển Rộng Sông Dài",
        87000,
        0.20,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/8/9/8935325004438.jpg"
    );

call
    insert_book_with_main_image(
        "name Vô Thường (Tái Bản 2018)",
        63000,
        0.20,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/f/7/f7992bd171a14232b2ca827967c7f774_310x514_1.jpg"
    );

call
    insert_book_with_main_image(
        "name Cảm Ơn Anh Đã Đánh Mất Em",
        79000,
        0.20,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/b/b/bbbcam-on-anh-da-danh-mat-em.jpg"
    );

call
    insert_book_with_main_image(
        "name Ngắm Mùa Trôi Qua Cửa Sổ",
        79200,
        0.20,
        50,
        'Truyện Ngắn - Tản Văn',
        "https://cdn0.fahasa.com/media/catalog/product/i/m/image_244718_1_5808.jpg"
    );

/*  */

call
    insert_book_with_main_image(
        "Nghĩ Giàu & Làm Giàu (Tái Bản 2020)",
        77000,
        0.30,
        50,
        'Nhân Vật - Bài Học Kinh Doanh',
        "https://cdn0.fahasa.com/media/catalog/product/n/g/nghigiaulamgiau_110k-01_bia-1.jpg"
    );

call
    insert_book_with_main_image(
        "Netflix: Phá Bỏ Nguyên Tắc Để Bứt Phá - No Rules Rules: Netflix And The Culture Of Reinvention",
        158400,
        0.20,
        50,
        'Nhân Vật - Bài Học Kinh Doanh',
        "https://cdn0.fahasa.com/media/catalog/product/n/x/nxbtre_full_27202022_112029.jpg"
    );

call
    insert_book_with_main_image(
        "Tại Sao Chúng Tôi Muốn Bạn Giàu (Tái Bản 2022)",
        108000,
        0.20,
        50,
        'Nhân Vật - Bài Học Kinh Doanh',
        "https://cdn0.fahasa.com/media/catalog/product/8/9/8934974177630.jpg"
    );

call
    insert_book_with_main_image(
        "Từ Tốt Đến Vĩ Đại - Jim Collins (Tái Bản 2021)",
        104000,
        0.20,
        50,
        'Nhân Vật - Bài Học Kinh Doanh',
        "https://cdn0.fahasa.com/media/catalog/product/n/x/nxbtre_full_09462021_024609.jpg"
    );

call
    insert_book_with_main_image(
        "Những Kẻ Xuất Chúng (Tái Bản 2021)",
        127200,
        0.20,
        50,
        'Nhân Vật - Bài Học Kinh Doanh',
        "https://cdn0.fahasa.com/media/catalog/product/i/m/image_230370.jpg"
    );

call
    insert_book_with_main_image(
        "Bán Hàng Shopee Thực Chiến Từ A-Z - 36 Chiến Lược Đỉnh Cao Bùng Nổ Doanh Số (Tái Bản)",
        199200,
        0.20,
        50,
        'Nhân Vật - Bài Học Kinh Doanh',
        "https://cdn0.fahasa.com/media/catalog/product/9/7/9786043588644_1.jpg"
    );

call
    insert_book_with_main_image(
        "Không Bao Giờ Là Thất Bại! Tất Cả Là Thử Thách - Bìa Cứng",
        214000,
        0.20,
        50,
        'Nhân Vật - Bài Học Kinh Doanh',
        "https://cdn0.fahasa.com/media/catalog/product/k/h/khongbaogiothatbai_bia01.jpg"
    );

call
    insert_book_with_main_image(
        "Lời Thú Tội Mới Của Một Sát Thủ Kinh Tế",
        152000,
        0.20,
        50,
        'Nhân Vật - Bài Học Kinh Doanh',
        "https://cdn0.fahasa.com/media/catalog/product/l/o/loithutoicuamotsatthukinhte.jpg"
    );

call
    insert_book_with_main_image(
        "Cách Netflix Xây Dựng Con Người: Sức Mạnh Của Văn Hóa Tự Do Và Trách Nhiệm",
        64000,
        0.20,
        50,
        'Nhân Vật - Bài Học Kinh Doanh',
        "https://cdn0.fahasa.com/media/catalog/product/i/m/image_196897.jpg"
    );

call
    insert_book_with_main_image(
        "Những Nguyên Lý Quản Trị Bất Biến Mọi Thời Đại",
        110400,
        0.20,
        50,
        'Nhân Vật - Bài Học Kinh Doanh',
        "https://cdn0.fahasa.com/media/catalog/product/i/m/image_203580.jpg"
    );

call
    insert_book_with_main_image(
        "Trên Đỉnh Phố Wall (Tái Bản 2021)",
        175200,
        0.20,
        50,
        'Nhân Vật - Bài Học Kinh Doanh',
        "https://cdn0.fahasa.com/media/catalog/product/i/m/image_230105.jpg"
    );

call
    insert_book_with_main_image(
        "7 Phương Pháp Đầu Tư Warren Buffet",
        111200,
        0.20,
        50,
        'Nhân Vật - Bài Học Kinh Doanh',
        "https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_10704.jpg"
    );

call
    insert_book_with_main_image(
        "Thấu Hiểu Tiếp Thị Từ A Đến Z - 80 Khái Niệm Nhà Quản Lý Cần Biết (Tái Bản 2020)",
        92000,
        0.20,
        50,
        'Nhân Vật - Bài Học Kinh Doanh',
        "https://cdn0.fahasa.com/media/catalog/product/n/x/nxbtre_full_31432020_024333_2_1.jpg"
    );

call
    insert_book_with_main_image(
        "Phương Pháp Đầu Tư Warren Buffett (Tái Bản)",
        135200,
        0.20,
        50,
        'Nhân Vật - Bài Học Kinh Doanh',
        "https://cdn0.fahasa.com/media/catalog/product/i/m/image_239209.jpg"
    );

call
    insert_book_with_main_image(
        "Bán Lẻ Thông Minh",
        128000,
        0.20,
        50,
        'Nhân Vật - Bài Học Kinh Doanh',
        "https://cdn0.fahasa.com/media/catalog/product/i/m/image_217466.jpg"
    );

call
    insert_book_with_main_image(
        "Bản Đồ Thành Công Nghề BHNT - 12 Bước Trở Thành MDRT",
        209300,
        0.30,
        50,
        'Nhân Vật - Bài Học Kinh Doanh',
        "https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_48205.jpg"
    );

call
    insert_book_with_main_image(
        "Đừng Bán Bảo Hiểm Hãy Trao Giải Pháp - Sách Gối Đầu Dành Cho Tư Vấn Bảo Hiểm Nhân Thọ (Tái Bản 2020)",
        96000,
        0.20,
        50,
        'Nhân Vật - Bài Học Kinh Doanh',
        "https://cdn0.fahasa.com/media/catalog/product/i/m/image_218469.jpg"
    );

call
    insert_book_with_main_image(
        "Chuyện Lẩu Cua - Ngụ Ngôn Về Sự Chuyển Hóa Văn Hóa Doanh Nghiệp Từ Mekong Capital",
        135200,
        0.20,
        50,
        'Nhân Vật - Bài Học Kinh Doanh',
        "https://cdn0.fahasa.com/media/catalog/product/z/3/z3426152224458_0ae3a53af12d7030e241f906f98fd8a8.jpg"
    );

call
    insert_book_with_main_image(
        "Dốc Hết Trái Tim (Tái Bản 2018)",
        120000,
        0.20,
        50,
        'Nhân Vật - Bài Học Kinh Doanh',
        "https://cdn0.fahasa.com/media/catalog/product/8/9/8934974152361_11.jpg"
    );

call
    insert_book_with_main_image(
        "Từ Zero Đến Zara",
        76000,
        0.20,
        50,
        'Nhân Vật - Bài Học Kinh Doanh',
        "https://cdn0.fahasa.com/media/catalog/product/i/m/image_180164_1_43_1_57_1_4_1_2_1_210_1_29_1_98_1_25_1_21_1_5_1_3_1_18_1_18_1_45_1_26_1_32_1_14_1_596.jpg"
    );

call
    insert_book_with_main_image(
        "14 Nguyên Tắc Tăng Trưởng Thần Tốc Như Amazon",
        150400,
        0.20,
        50,
        'Nhân Vật - Bài Học Kinh Doanh',
        "https://cdn0.fahasa.com/media/catalog/product/1/4/14nguyentactangtruongthantoc_bia-01_2.jpg"
    );

call
    insert_book_with_main_image(
        "Jeff Bezos Và Kỷ Nguyên Amazon (Tái Bản 2019)",
        88000,
        0.20,
        50,
        'Nhân Vật - Bài Học Kinh Doanh',
        "https://cdn0.fahasa.com/media/catalog/product/i/m/image_190426.jpg"
    );
