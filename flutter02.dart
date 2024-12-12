import 'package:flutter/material.dart';

//Trang thứ nhất
class FirstPage extends StatelessWidget{
  const FirstPage({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Động phong nha kẻ bàng',
        style: TextStyle(
            color: Colors.blueAccent,
          fontSize: 25
        )),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset('../assets/images/PhongNha2.jpg',
              width: 750,
              height: 350,
              fit: BoxFit.cover,),
            SizedBox(height: 25,),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> SecondPage()),
                  );
                },
                child: Text('Thêm ảnh')),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phong nha kẻ bàng'),
        // Nút back sẽ tự động xuất hiện và gọi Navigator.pop khi được nhấn
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('../assets/images/PhongNha1.jpg',width: 750,
              height: 350,
              fit: BoxFit.cover,),
            SizedBox(height: 20),
            // Nút để quay lại trang 1
            ElevatedButton(
              onPressed: () {
                // Sử dụng Navigator.pop để quay lại trang trước
                Navigator.pop(context);
              },
              child: Text('Hình trước'),
            ),
            SizedBox(height: 20),
            // Nút để đi đến trang 3
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThirdPage()),
                );
              },
              child: Text('Thêm ảnh'),
            ),
          ],
        ),
      ),
    );
  }
}

// Trang thứ ba
class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phong nha kẻ bàng'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('../assets/images/PhongNha4.jpg',
              width: 750,
              height: 350,
              fit: BoxFit.cover,),
            SizedBox(height: 20),
            // Nút để quay lại trang trước
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Hình trước'),
            ),
            SizedBox(height: 20),
            // Nút để quay về trang đầu tiên
            ElevatedButton(
              onPressed: () {
                // Xóa tất cả các trang trong stack và quay về trang đầu
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => FirstPage()),
                      (route) => false,
                );
              },
              child: Text('Ảnh đầu tiên'),
            ),
          ],
        ),
      ),
    );
  }
}
