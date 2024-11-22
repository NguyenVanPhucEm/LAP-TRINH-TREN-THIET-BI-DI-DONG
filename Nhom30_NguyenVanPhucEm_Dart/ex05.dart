/*
- Giai phuong trinh ax^2 + bx + c = 0
*/
import 'dart:io';
import 'dart:math';

void main() {
  double a = 0, b = 0, c = 0;
  //Input a

  do {
    stdout.write('Nhap he so a (a khac 0): ');
    String? inputa = stdin.readLineSync();
    if (inputa != null) {
      a = double.tryParse(inputa) ?? 0;
    }
    if (a == 0) {
      print('Vui long nhap lai!\n');
    }
  } while (a == 0);

  //Input b

  stdout.write('Nhap he so b: ');
  String? inputb = stdin.readLineSync();
  if (inputb != null) {
    b = double.tryParse(inputb) ?? 0;
    print('so b: $b');
  }
  //Input c

  stdout.write('Nhap he so c: ');
  String? inputc = stdin.readLineSync();
  if (inputc != null) {
    c = double.tryParse(inputc) ?? 0;
  }
  // Hien thi phuong trinh
  print('Phuong trinh: ${a}x^2 + ${b}x + $c = 0');
  // Tinh Denta = b^2 - 4*a*c
  double denta = b*b - 4*a*c;

  //Giai phuong trinh
  if(denta < 0){
    print('Phuong trinh vo nghiem');
  }else if(denta==0){
    double x = -b/(2*a);
    //lay 2 so sau dau phay
    //ham toString se la chuoi nen can phai ep la thanh double
    x = double.parse(x.toStringAsFixed(2));
    print('Phuong trinh co 1 nghiem kep: $x');
  }else{
    double x1 = (-b + sqrt(denta)) / (2*a);
    double x2 = (-b - sqrt(denta)) / (2*a);
    x1 = double.parse(x1.toStringAsFixed(2));
    x2 = double.parse(x2.toStringAsFixed(2));
    print('Phuong trinh co hai nghiem: \n');
    print('x1: $x1');
    print('x1: $x2');
  }
  }
