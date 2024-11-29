import 'dienthoai.dart';
import 'hoadon.dart';

typedef luuvet = Dienthoai Function(Dienthoai dt, int sl);

class CuaHang {
  String _tenCuaHang;
  String _diaChi;
  List<Dienthoai> _dienThoai = [];
  List<HoaDon> _hoaDon = [];
  //Lưu trữ thông tin madienthoai và số lần bán để thực hiện thống kê top những mặt hàng bán chạy
  Map<String, int> soluongban = {};
  //Luu những mặt hàng vào list để sắp xếp
  List<Map<String, int>> soluongban1 = [];

  //Contructor
  CuaHang(this._tenCuaHang, this._diaChi);

  //getters
  String get tenCuaHang => _tenCuaHang;
  String get diaChi => _diaChi;

  //setters
  set tenCuaHang(String tenCuaHang) {
    _tenCuaHang = (tenCuaHang.isNotEmpty) ? tenCuaHang : _tenCuaHang;
  }

  set diaChi(String diaChi) {
    _diaChi = (diaChi.isNotEmpty) ? diaChi : _diaChi;
  }

//Chuyển đổi dữ liệu người dùng nhập từ bàn phím sang kiểu datetime
  DateTime? ChuyenDoiDinhDangNgay(String? ngay) {
    try {
      // Tách chuỗi theo dấu "/"
      if (ngay == null) {
        return null;
      }
      List<String> parts = ngay.split('/');
      if (parts.length != 3) {
        throw FormatException("Chuỗi không đúng định dạng dd/MM/yyyy");
      }

      // Chuyển đổi từng phần sang số nguyên
      int day = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int year = int.parse(parts[2]);

      // Tạo đối tượng DateTime
      return DateTime(year, month, day);
    } catch (e) {
      print(
          "Lỗi: Chuỗi không đúng định dạng hoặc giá trị không hợp lệ. Chi tiết: $e");
      return null;
    }
  }

  //Them dien thoai moi vao cua hang
  void ThemDienThoaiMoiVaoCuaHang(Dienthoai dt) {
    _dienThoai.add(dt);
    print('Đã thêm điện thoại ${dt.tenDT} vào csdl của cửa hàng');
  }

  void HienThiThongTinDienThoai() {
    for (var item in _dienThoai) {
      item.HienThiThongTin();
    }
  }

  //Kiểm tra tồn tại của điện thoại dựa trên madt
  bool kiemtratontaidienthoai(madt) {
    for (var item in _dienThoai) {
      if (item.maDT == madt) return true;
    }
    return false;
  }

  void CapNhatThongTinDienThoai(Dienthoai dt) {
    // tìm kiếm điện thoại cần cập nhật thông tin nếu có thì cập nhật nếu khong tìm thấy thì thongp báo không thấy mã điện thoại
    var dienthoai = _dienThoai.firstWhere((p) => p.maDT == dt.maDT);
    dienthoai.tenDT = dt.tenDT;
    dienthoai.giaBan = dt.giaBan;
    dienthoai.giaNhap = dt.giaNhap;
    dienthoai.hangSX = dt.hangSX;
    dienthoai.slTon = dt.slTon;
    print('Đã cập nhật thành công điện thoại ${dt.tenDT}');
  }

  void NgungKinhDoanhDienThoai(String madt) {
    //tìm kiếm điện thoại theo ma dien thoai

    for (var dienthoai in _dienThoai) {
      if (dienthoai.maDT == madt) {
        if (dienthoai.trangThai) {
          dienthoai.trangThai = false;
          print('Đã ngưng hoạt động của điện thoại bạn vừa nhập');
        } else {
          print(
              'Hiện tại điện thoại này đã ngưng hoạt động nên việc ngưng hoạt động là không cần thiết!');
        }
      }
    }
  }

//tìm kiếm hóa đơn dựa trên mã điện thoại hay tên điện thoại hay hãng sản xuất
  Dienthoai? TimKiemDienThoaiTheo_Ma_Ten_Hang(
      String? madt, String? tendt, String? hangsx) {
    if (madt != null || tendt != null || hangsx != null) {
      for (var item in _dienThoai) {
        if (item.maDT == madt || item.tenDT == tendt || item.hangSX == hangsx)
          return item;
      }
    }
    return null;
  }

//tạo hóa đơn mới
  void TaoHoaDonMoi(HoaDon hd) {
    _hoaDon.add(hd);
    var dienthoai =
        _dienThoai.firstWhere((p) => p.maDT == hd.dienThoaiDuocBan.maDT);
    //cập nhật số lượng tồn
    dienthoai.slTon -= hd.slMua;
    print('Hóa đơn đã được tạo');
  }

//tìm kiếm hóa đơn theo ngày . tên khách hàng hoặc mã hóa đơn
  List<HoaDon> TimKiemHoaDonTheo_Ma_Ngay_KhachHang(
      String? mahd, String? ngay, String? khachhang) {
    var searchngay = ChuyenDoiDinhDangNgay(ngay);
    List<HoaDon> hd = [];
    for (var item in _hoaDon) {
      if (item.maHD == mahd ||
          item.ngayBan == ngay ||
          item.tenKH == khachhang) {
        hd.add(item);
      }
    }
    return hd;
  }

//Xuất tất cả các hóa đơn
  void HienThiThongTinHoaDon() {
    for (var item in _hoaDon) {
      item.HienThiThongTin();
    }
  }

//tinh tổng doanh thu theo khoảng thời gian
  double TongDoanhThuTheoKhoangThoiGian(String ngaybt, String ngaykt) {
    var StarDate = ChuyenDoiDinhDangNgay(ngaybt);
    var EndDate = ChuyenDoiDinhDangNgay(ngaykt);
    double total = 0;
    //
    if (StarDate != null && EndDate != null) {
      //Xét từ trước ngày bắt đầu 1 ngày và sau ngày kết thúc 1 ngày
      StarDate = StarDate.subtract(Duration(days: 1));
      EndDate = EndDate.add(Duration(days: 1));

      for (var item in _hoaDon) {
        if (item.ngayBan.isAfter(StarDate) && item.ngayBan.isBefore(EndDate)) {
          total += item.TongTien();
        }
      }
      return total;
    }
    return total;
  }

//Tinh tong loi nhuận theo khoảng thời gian
  double TongLoiNhuanTheoKhoangThoiGian(String ngaybt, String ngaykt) {
    var StarDate = ChuyenDoiDinhDangNgay(ngaybt);
    var EndDate = ChuyenDoiDinhDangNgay(ngaykt);
    double total = 0;
    //
    if (StarDate != null && EndDate != null) {
      //Xét từ trước ngày bắt đầu 1 ngày và sau ngày kết thúc 1 ngày
      StarDate = StarDate.subtract(Duration(days: 1));
      EndDate = EndDate.add(Duration(days: 1));

      for (var item in _hoaDon) {
        if (item.ngayBan.isAfter(StarDate) && item.ngayBan.isBefore(EndDate)) {
          total += item.LoiNhuanThucTe();
        }
      }
      return total;
    }
    return total;
  }

//Sắp xếp giá trị mua của điện thoại tăng dần dựa trên listmap
  void sapXepListMapTangDan(List<Map<String, int>> list) {
    list.sort((a, b) {
      // Lấy giá trị int từ các Map và so sánh chúng
      return a.values.first.compareTo(b.values.first);
    });
  }

//Thống kê điện thoại bán chạy
  void ThongKeTopDienThoaiBanChay(int n) {
    for (var HD in _hoaDon) {
      String maDT = HD.dienThoaiDuocBan.maDT;
      //Lưu thông tin vào map
      soluongban[maDT] = (soluongban[maDT] ?? 0) + HD.slMua;
      //kiểm duyệt trên list map
      for (var map in soluongban1) {
        map.forEach((key, value) {
          // Nếu key đã tồn tại, cộng dồn giá trị
          if (soluongban.containsKey(key)) {
            soluongban[key] = soluongban[key]! + value;
          } else {
            // Nếu chưa tồn tại, thêm mới vào list map
            soluongban1.add(soluongban);
          }
        });
      }
    }
    sapXepListMapTangDan(soluongban1);
    if (soluongban1.length > n) {
      var topn = soluongban1.take(n).toList();
      print('Top $n điện thoại bán chạy nhất là: $topn');
      return;
    }
    print('Top điện thoại bán chạy la: $soluongban1');
  }

//Thống kê tồn kho của các loại điện thoại
  void ThongKeTonKho() {
    print('------------');
    for (var item in _dienThoai) {
      print('Điện thoại ${item.tenDT}: còn : ${item.slTon}');
    }
  }
}
