import 'dienthoai.dart';

class HoaDon {
  String _maHD;
  DateTime _ngayBan;
  String _tenKH;
  String _sdtKH;
  Dienthoai _dienThoaiDuocBan;
  double _giaBanThucTe;
  int _slMua;

  //Contructor
  HoaDon(this._maHD, this._ngayBan, this._dienThoaiDuocBan, this._slMua,
      this._giaBanThucTe, this._tenKH, this._sdtKH);

  //getters
  String get maHD => _maHD;
  DateTime get ngayBan => _ngayBan;
  Dienthoai get dienThoaiDuocBan => _dienThoaiDuocBan;
  int get slMua => _slMua;
  double get giaBanThucTe => _giaBanThucTe;
  String get tenKH => _tenKH;
  String get sdtKH => _sdtKH;

  //setters
  set maHD(String maHD) {
    if (maHD.isNotEmpty && KiemtraDinhDangMaHD(maHD)) {
      _maHD = maHD;
    }
  }

  set ngayBan(DateTime ngayBan) {
    if (ngayBan.isBefore(DateTime.now())) {
      _ngayBan = ngayBan;
    }
  }

  set slMua(int slMua) {
    _slMua = (slMua > 0 && slMua < dienThoaiDuocBan.slTon) ? slMua : _slMua;
  }

  set giaBanThucTe(double giaBanThucTe) {
    _giaBanThucTe = (giaBanThucTe > 0) ? giaBanThucTe : _giaBanThucTe;
  }

  set tenKH(String tenKH) {
    _tenKH = (tenKH.isNotEmpty) ? tenKH : _tenKH;
  }

  set sdtKH(String sdtKH) {
    _sdtKH = (sdtKH.isNotEmpty && KiemTraDinhDangSDT(sdtKH) ? sdtKH : _sdtKH);
  }

  bool KiemtraDinhDangMaHD(String maHD) {
    // Biểu thức chính quy kiểm tra định dạng DT-XXX
    RegExp regex = RegExp(r'^HD-[a-zA-Z0-9]+$');
    return regex.hasMatch(maHD);
  }

  bool KiemTraDinhDangSDT(String sdtKH) {
    // Biểu thức chính quy kiểm tra chuỗi bắt đầu bằng 0 và theo sau là 9 chữ số
    RegExp regex = RegExp(r'^0\d{9}$');
    return regex.hasMatch(sdtKH);
  }

  DateTime ChuyenDoiDinhDangNgay(String ngayBan) {
    List<String> parts = ngayBan.split('/'); // Tách chuỗi theo dấu '/'

    // Chuyển đổi thành định dạng ISO 8601 (YYYY-MM-DD)
    String formattedDate = "${parts[2]}-${parts[1]}-${parts[0]}";

    // Parse thành DateTime
    DateTime date = DateTime.parse(formattedDate);
    return date; // Output: 2024-11-28 00:00:00.000
  }

  double TongTien() {
    return _giaBanThucTe * _slMua;
  }

  double LoiNhuanThucTe() {
    return (_giaBanThucTe - (dienThoaiDuocBan.giaNhap)) * _slMua;
  }

  void HienThiThongTin() {
    print('------------------------');
    print('----Hóa Đơn Bán Hàng----');
    print('Mã hóa đơn: $_maHD');
    print('Ngày bán: $_ngayBan');
    print('Điện thoại được bán: ${_dienThoaiDuocBan.tenDT}');
    print('Số lượng mua: $_slMua');
    print('Giá bán: $_giaBanThucTe');
    print('---Thông tin khác hàng---');
    print('Tên khách hàng: $_tenKH');
    print('Số điện thoại: $sdtKH');
  }
}
