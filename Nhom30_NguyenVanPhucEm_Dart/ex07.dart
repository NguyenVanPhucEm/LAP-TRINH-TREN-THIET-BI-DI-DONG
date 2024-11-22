//Tinh tong cac uoc so cua 1 so nguyen 
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

  //Tim cac uoc so cua so vua nhap
  List<int> uocso = [];
  //uoc so cua 1 so bao gom 1 va chinh no
  uocso.addAll([1,6]);
  
  for(int i = 2 ; i<n; i++){
    if(n%i == 0){
      uocso.add(i);
    }
  }
  int tongso = 0;
  //tinh tong so uoc chung cua n
  uocso.forEach((n1) => tongso += n1 );
  print('Tong so uoc chung cua$n la: $tongso');
}