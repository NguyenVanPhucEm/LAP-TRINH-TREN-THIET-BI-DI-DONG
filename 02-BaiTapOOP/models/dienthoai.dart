class Dienthoai {
  String _maDT;
  String _tenDT;
  String _hangSX;
  double _giaNhap;
  double _giaBan;
  int _slTon;
  bool _trangThai;

  //contructor
  Dienthoai(this._maDT, this._tenDT, this._hangSX, this._giaNhap, this._giaBan,
      this._slTon, this._trangThai);

  //getter
  String get maDT => _maDT;
  String get tenDT => _tenDT;
  String get hangSX => _hangSX;
  double get giaNhap => _giaNhap;
  double get giaBan => _giaBan;
  int get slTon => _slTon;
  bool get trangThai => _trangThai;
  //setters

  bool KiemTraMaDienThoai(String maDT) {
    // Biểu thức chính quy kiểm tra định dạng DT-XXX
    RegExp regex = RegExp(r'^DT-[a-zA-Z0-9]+$');
    return regex.hasMatch(maDT);
  }

  set maDT(String maDT) {
    if (maDT.isNotEmpty && KiemTraMaDienThoai(maDT)) {
      _maDT = maDT;
    }
  }

  set tenDT(String tenDT) {
    _tenDT = (tenDT.isNotEmpty) ? tenDT : _tenDT;
  }

  set hangSX(String hangSX) {
    _hangSX = (hangSX.isNotEmpty) ? hangSX : _hangSX;
  }

  set giaNhap(double giaNhap) {
    _giaNhap = (giaNhap > 0) ? giaNhap : _giaNhap;
  }

  set giaBan(double giaBan) {
    _giaBan = (giaBan > 0 && giaBan > giaNhap) ? giaBan : _giaBan;
  }

  set slTon(int slTon) {
    _slTon = (slTon >= 0) ? slTon : _slTon;
  }

  set trangThai(bool tranghThai) {
    _trangThai = tranghThai;
  }

  double LoiNhuanDuKien() {
    return (_giaBan - _giaNhap) * _slTon;
  }

  void HienThiThongTin() {
    print('----------------------');
    print("Mã điện thoại: $_maDT");
    print("Tên điện thoại: $_tenDT");
    print("Hãng sản xuất: $_hangSX");
    print("Giá nhập: $_giaNhap");
    print("Giá bán: $_giaBan");
    print("Số lượng tồn: $_slTon");
    print("Lơi nhuận: ${LoiNhuanDuKien()}");
    if (trangThai) {
      print("Trạng thái: Đang bán");
    } else {
      print("Trạng thái: Đã ngưng bán");
    }
  }

  bool KiemTraMatHang() {
    return _trangThai;
  }
}
