import 'dart:isolate';

import 'dienthoai.dart';
import 'dart:io';
import 'cuahang.dart';
import 'hoadon.dart';

void main() {
  int luachon = 0;
  Dienthoai dt;
  HoaDon hd;
  CuaHang cuahang;
//Không cho phép người dùng nhập dữ liệu rỗng hoặc null
  String nhapThongTin(String thongBao) {
    String? input;
    do {
      print(thongBao);
      input = stdin.readLineSync();
      if (input == null || input.trim().isEmpty) {
        print("Giá trị không được để trống. Vui lòng nhập lại!");
      }
    } while (input == null || input.trim().isEmpty);
    return input;
  }

  print('Hãy tạo cửa hàng cho riêng bạn!');
  String tench = nhapThongTin('Nhập tên cửa hàng: ');
  String diachi = nhapThongTin('Nhập địa chỉ: ');
  cuahang = new CuaHang(tench, diachi);

//Thiết lập mô hình switch case để test các chức năng của mô hình cửa hàng điện thoại
  do {
    print(
        '--------Chào mừng đến với hệ thống cửa hàng điện thoại ${cuahang.tenCuaHang}--------');
    print('---Hãy thử trải nghiệm hệ thống với các chức năng tuyệt vời---');
    print('1. Quản lý điện thoại');
    print('2. Quản lý hóa đơn');
    print('3. Thống kê');
    print('0. Thoát.');
    print('Hãy bắt đầu với chức năng số: ');
    String? LC = stdin.readLineSync();
    if (LC != null) {
      luachon = int.parse(LC) ?? 0;
    }
    switch (luachon) {
      case 1:
        {
          int chucnang = 0;
          do {
            print('-----Quản lý điện thoại -----');
            print('1. Thêm điện thoại mới');
            print('2. Cập nhật thông tin điện thoại');
            print('3. Ngưng kinh doanh điện thoại');
            print('4. Tìm kiếm điện thoại');
            print('5. Hiển thị danh sách điện thoại');
            print('0. Thoát chức năng!');
            String lc = nhapThongTin('Hãy thực hiện chức năng: ');
            chucnang = int.parse(lc) ?? 0;
            switch (chucnang) {
              case 1:
                {
                  // yêu cầu nhập thông tin điện thoại
                  print('--- Thêm thông tin điện thoại ---');
                  String maDT = nhapThongTin('Nhập mã điện thoại:');
                  String tenDT = nhapThongTin('Nhập tên điện thoại:');
                  String hangSX = nhapThongTin('Nhập hãng sản xuất:');
                  String giaNhap = nhapThongTin('Nhập giá nhập:');
                  String giaBan = nhapThongTin('Nhập giá bán:');
                  String sl = nhapThongTin('Nhập số lượng:');
                  //Kiểm tra giá trị trả về của các kiểu dữ liệu số
                  //Nếu người dùng nhập không đúng các dữ liệu số thì mặc định sẽ là 0
                  try {
                    dt = new Dienthoai(
                        maDT,
                        tenDT,
                        hangSX,
                        double.parse(giaNhap) ?? 0,
                        //vì giá bán phải lớn hơn giá nhập nên cho 0.1
                        double.parse(giaBan) ?? 0.1,
                        int.parse(sl) ?? 0,
                        // mặc định khi tạo 1 điện thoại thì cho phép bán
                        true);
                    //Kiểm tra mã điện thoại đã đúng yêu cầu chưa
                    if (!dt.KiemTraMaDienThoai(dt.maDT)) {
                      print('Bạn đã nhập sai mã vui lòng nhập lại!!');
                      break;
                    }
                    // Sau khi tạo 1 điện thoại thì thêm điện thoại vào trong list điện thoại của cửa hàng
                    cuahang.ThemDienThoaiMoiVaoCuaHang(dt);
                  } catch (e) {
                    print('Đã xảy ra lỗi $e');
                  }
                  break;
                }
              case 2:
                {
                  // yêu cầu nhập thông tin điện thoại
                  print('--- Cập nhật thông tin điện thoại ---');
                  String maDT =
                      nhapThongTin('Nhập mã điện thoại cần cập nhật:');

                  var DT = cuahang.kiemtratontaidienthoai(maDT);
                  if (!DT) {
                    print('Không tồn tại điện thoại có mã $maDT');
                    break;
                  }
                  String? tenDT = nhapThongTin('Cập nhật tên điện thoại:');
                  String hangSX = nhapThongTin('Cập nhật hãng sản xuất:');
                  String giaNhap = nhapThongTin('Nhập giá nhập:');
                  String giaBan = nhapThongTin('Nhập giá bán:');
                  String sl = nhapThongTin('Nhập số lượng:');
                  //Kiểm tra giá trị trả về của các kiểu dữ liệu số
                  //Nếu người dùng nhập không đúng các dữ liệu số thì mặc định sẽ là 0
                  try {
                    dt = new Dienthoai(
                        maDT,
                        tenDT,
                        hangSX,
                        double.parse(giaNhap) ?? 0,
                        //vì giá bán phải lớn hơn giá nhập nên cho 0.1
                        double.parse(giaBan) ?? 0.1,
                        int.parse(sl) ?? 0,
                        // mặc định khi tạo 1 điện thoại thì không cho phép bán
                        false);

                    // Sau khi tạo 1 điện thoại thì thêm điện thoại vào trong list điện thoại của cửa hàng
                    cuahang.CapNhatThongTinDienThoai(dt);
                  } catch (e) {
                    print('Đã xảy ra lỗi $e');
                  }
                  break;
                }
              case 3:
                {
                  print('--- Ngưng kinh doanh điện thoại--');
                  String madt = nhapThongTin(
                      'Nhập mã điện thoại bạn muốn ngưng kinh doanh');
                  cuahang.NgungKinhDoanhDienThoai(madt);
                  break;
                }
              case 4:
                {
                  print('---Tìm kiếm điện thoại---');
                  print('1. Tìm kiếm theo mã điện thoại');
                  print('2. Tìm kiếm theo tên điện thoại');
                  print('3. Tìm kiếm theo hãng');
                  String n = nhapThongTin('Bạn chọn tìm theo: ');
                  int search = int.parse(n) ?? 0;
                  if (search == 1) {
                    String? madt =
                        nhapThongTin('Nhập mã điện thoại cần thực hiện: ');
                    var dt = cuahang.TimKiemDienThoaiTheo_Ma_Ten_Hang(
                        madt, null, null);
                    if (dt == null) {
                      print('Không có điện thoại bạn cần tìm');
                    } else {
                      dt.HienThiThongTin();
                    }
                  } else if (search == 2) {
                    String? tendt =
                        nhapThongTin('Nhập tên điện thoại cần thực hiện: ');
                    var dt = cuahang.TimKiemDienThoaiTheo_Ma_Ten_Hang(
                        null, tendt, null);
                    if (dt == null) {
                      print('Không có điện thoại bạn cần tìm');
                    } else {
                      dt.HienThiThongTin();
                    }
                  } else if (search == 3) {
                    String? hangsx = nhapThongTin(
                        'Nhập hãng sản xuất điện thoại cần thực hiện: ');
                    var dt = cuahang.TimKiemDienThoaiTheo_Ma_Ten_Hang(
                        null, null, hangsx);
                    if (dt == null) {
                      print('Không có điện thoại bạn cần tìm');
                    } else {
                      dt.HienThiThongTin();
                    }
                  } else {
                    print('Không có chức năng này');
                  }

                  break;
                }
              case 5:
                {
                  print('-----Danh Sách điện thoại của cửa hàng ------');
                  cuahang.HienThiThongTinDienThoai();
                  break;
                }
              default:
                {
                  print('Không có chức năng cho thao tác của bạn!');
                  break;
                }
            }
          } while (chucnang != 0);
          break;
        }
      case 2:
        {
          int chucnang = 0;
          do {
            print('-----Quản lý hóa đơn -----');
            print('1. Tạo hóa đơn mới');
            print('2. Tìm kiếm hóa đơn');
            print('3. Hiển thị danh sách hóa đơn');
            print('0. Thoát chức năng');
            String lc = nhapThongTin('Hãy thực hiện chức năng: ');
            chucnang = int.parse(lc) ?? 0;
            switch (chucnang) {
              case 1:
                {
                  print('----Tạo hóa đơn mới ---');
                  print('Hoàn thành những thông tin bên dưới để tạo 1 hóa đơn');
                  String mahd = nhapThongTin('Nhập mã hóa đơn: ');
                  DateTime ngayban = DateTime.now().subtract(Duration(days: 1));
                  String madt = nhapThongTin("Mã điện thoại cần bán: ");
                  String slMua = nhapThongTin("Số lượng mua: ");
                  String giaBan = nhapThongTin("giá bán thực tế: ");
                  String tenKH = nhapThongTin("Tên khách hàng: ");
                  String Sodt = nhapThongTin("Số điện thoại: ");
                  // sau khi nhập đầy đủ thông tin thì thực hiện tìm điện thoại cần bán
                  var dienthoai = cuahang.TimKiemDienThoaiTheo_Ma_Ten_Hang(
                      madt, null, null);
                  //kiểm tra tồn tại cảu điện thoại
                  if (dienthoai != null) {
                    hd = new HoaDon(
                        mahd,
                        ngayban,
                        dienthoai,
                        int.parse(slMua) ?? 0,
                        double.parse(giaBan) ?? 0.1,
                        tenKH,
                        Sodt);
                    // kiểm tra tính toàn vẹn của mã hóa đơn và sdt
                    if (!hd.KiemtraDinhDangMaHD(hd.maHD)) {
                      print('Nhập sai mã hóa đơn!!');
                      break;
                    }
                    if (!hd.KiemTraDinhDangSDT(hd.sdtKH)) {
                      print('Nhập sai số điện thoại!!');
                      break;
                    }
                    //So sánh số lượng tồn và số lượng mua của sản phẩm
                    if (dienthoai.slTon < hd.slMua) {
                      print(
                          'Số lượng không đủ để đáp ưng. Hiện tại chỉ còn ${dienthoai.slTon} chiếc');
                      break;
                    }
                    // nếu không có gì sai xót ta có thể add và trong cửa hàng
                    cuahang.TaoHoaDonMoi(hd);
                    break;
                  }
                  //nếu có tồn tại điện thoại đó thì thực hiện tạo 1 hóa đơn
                  print('Không tồn tại điện thoại bạn vừa cung cấp!!');
                  break;
                }
              case 2:
                {
                  print('---Tìm kiếm hóa đơn---');
                  print('1. Tìm kiếm theo mã hóa đơn');
                  print('2. Tìm kiếm theo ngày');
                  print('3. Tìm kiếm theo khách hàng');
                  String n = nhapThongTin('Bạn chọn tìm theo: ');
                  int search = int.parse(n) ?? 0;
                  //thực hiện chức năng tìm kiếm
                  if (search == 1) {
                    var mahd = nhapThongTin("Nhập mã hóa đơn cần tìm: ");
                    var hoadon = cuahang.TimKiemHoaDonTheo_Ma_Ngay_KhachHang(
                        mahd, null, null);
                    if (hoadon.length == 0) {
                      print('Không có hóa đơn bạn cần tìm');
                      break;
                    }
                    for (var item in hoadon) {
                      item.HienThiThongTin();
                    }
                  } else if (search == 2) {
                    var ngay = nhapThongTin(
                        "Nhập ngày cần tìm(Lưu ý: nhập theo cú pháp dd/mm/yyyy): ");
                    var hoadon = cuahang.TimKiemHoaDonTheo_Ma_Ngay_KhachHang(
                        null, ngay, null);
                    if (hoadon.length == 0) {
                      print('Không có hóa đơn bạn cần tìm');
                      break;
                    }
                    if (hoadon == null)
                      for (var item in hoadon) {
                        item.HienThiThongTin();
                      }
                  } else if (search == 3) {
                    var khachhang = nhapThongTin("Nhập tên khách hàng: ");
                    var hoadon = cuahang.TimKiemHoaDonTheo_Ma_Ngay_KhachHang(
                        null, null, khachhang);
                    if (hoadon.length == 0) {
                      print('Không có hóa đơn bạn cần tìm');
                      break;
                    }
                    for (var item in hoadon) {
                      item.HienThiThongTin();
                    }
                  } else {
                    print(' không tồn tại chức năng này');
                  }
                  break;
                }
              case 3:
                {
                  print('--------Danh sách tất cả các hóa đơn -------');
                  cuahang.HienThiThongTinHoaDon();
                  break;
                }
              default:
                {
                  if (chucnang == 0) {
                    print('Cảm ơn banh đã dùng chức năng');
                  }
                  print('Không có chức năng này!!');
                }
            }
          } while (chucnang != 0);
          break;
        }
      case 3:
        {
          int chucnang = 0;
          do {
            print('----- Thống kê -----');
            print('1. Tổng doanh thu theo khoảng thời gian');
            print('2. Tổng lợi nhuận theo khoảng thời gian');
            print('3. Thống kê top điện thoại đang bán chạy');
            print('4. Thống kê tồn kho');
            String lc = nhapThongTin('Hãy thực hiện chức năng: ');
            chucnang = int.parse(lc) ?? 0;
            switch (chucnang) {
              case 1:
                {
                  String ngaybatdau = nhapThongTin(
                      'Chọn ngày bắt đầu(Lưu ý: thực hiện theo cú pháp: dd/mm/yyyy): ');
                  String ngayketthuc = nhapThongTin(
                      'Chọn ngày kết thúc(Lưu ý: thực hiện theo cú pháp: dd/mm/yyyy): ');

                  var total = cuahang.TongDoanhThuTheoKhoangThoiGian(
                      ngaybatdau, ngayketthuc);
                  if (total == 0) {
                    print(
                        'Không có số liệu về doanh thu trong khoảng tg này: ');
                    break;
                  }
                  print(
                      'Tổng doanh thu từ ngày $ngaybatdau đến ngày $ngayketthuc là: $total');
                  break;
                }
              case 2:
                {
                  String ngaybatdau = nhapThongTin(
                      'Chọn ngày bắt đầu(Lưu ý: thực hiện theo cú pháp: dd/mm/yyyy): ');
                  String ngayketthuc = nhapThongTin(
                      'Chọn ngày kết thúc(Lưu ý: thực hiện theo cú pháp: dd/mm/yyyy): ');

                  var total = cuahang.TongLoiNhuanTheoKhoangThoiGian(
                      ngaybatdau, ngayketthuc);
                  if (total == 0) {
                    print(
                        'Không có số liệu về lợi nhuận trong khoảng thời gian này: ');
                    break;
                  }
                  print(
                      'Tổng lợi nhuận thu được từ ngày $ngaybatdau đến ngày $ngayketthuc là: $total');
                  break;
                }
              case 3:
                {
                  print('-------Thống kê số lượng điện thoại bán chạy-------');
                  String sl =
                      nhapThongTin("Nhập số lượng điện thoại bạn muốn: ");
                  int SL = int.parse(sl) ?? 0;
                  if (SL != 0) {
                    cuahang.ThongKeTopDienThoaiBanChay(SL);
                    break;
                  }
                  print('Số lượng bạn nhập không hợp lệ!');
                  break;
                }
              case 4:
                {
                  print(
                      '-----------Tồn kho của các loại điện thoại trong cửa hàng ----------');
                  cuahang.ThongKeTonKho();
                  break;
                }
              default:
                {
                  if (chucnang == 0) {
                    print('Cảm ơn đã sủ dụng chức năng!!');
                    break;
                  }
                  print('Không có chức năng này!!');
                }
            }
          } while (chucnang != 0);
          break;
        }
      default:
        {
          if (luachon == 0) print('Cảm ơn quý khách đã sủ dụng dịch vụ');
          print(
              'Yêu cầu của quý khách hiện đang không tồn tại trong chức năng của chúng tôi!!');
          break;
        }
    }
  } while (luachon != 0);

//tạo ra hàm nhập thông tin để bắt buộc người dùng không bỏ trống dữ liệu
}
