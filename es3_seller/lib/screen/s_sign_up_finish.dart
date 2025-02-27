import 'package:es3_seller/const/colors.dart';
import 'package:flutter/material.dart';

class SignUpFinishScreen extends StatelessWidget {
  const SignUpFinishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Image.asset('assets/images/gift.png'),
            Text(
              'Seller membership registration has been completed.',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Your registration will be processed\nwithin 3 business days.\nYou will be notified via email once it is approved.\nWe sincerely appreciate you joining us,\nand we are committed to supporting your success',
              style: TextStyle(
                fontSize: 12
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed:(){
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MAIN_COLOR,
                ),
                child: Text(
                  'Go To Home',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
