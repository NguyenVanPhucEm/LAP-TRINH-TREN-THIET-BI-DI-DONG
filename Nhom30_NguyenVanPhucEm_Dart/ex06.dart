//Chuong trinh chuyen doi 1 so nguyen nhap tu ban phim thanh so nhi phan
import 'dart:io';

void main(){
  int n = 0;

  do{
    print('Nhap so nguyen n (n >= 1): ');
    String? inN = stdin.readLineSync();
    if(inN!=null)
    {
      //ep kieu string thanh int neu khong nhap so mat dinh la 0
      n = int.parse(inN) ?? 0;
    }
    if(n<1){
      print('Vui long nhap dung yeu cau!');
    }
  }while(n<1);
  print('So can chuyen thanh so nhi phan la: $n\n');

//khai bao 1 list chua sodu cuar phep tinh
  List<int> sodulist = [];
  do{
    sodulist.add(n%2);
    n=n~/2;
  }while(n!=0);

  print('So nhi phan cua no la: ');

  for(int i = sodulist.length - 1 ; i >= 0 ; i--){
    print(sodulist[i]);
  }
}