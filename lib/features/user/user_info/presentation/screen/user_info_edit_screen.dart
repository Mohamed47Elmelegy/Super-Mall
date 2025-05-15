import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_mall/shared/widget/appbar_back_title.dart';

class UserInfoEditScreen extends StatelessWidget {
  const UserInfoEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarBackTitle(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildAvatarImage(),
              SizedBox(height: 50.h),
              // _buildUserEditInfo(),
              _buildInfoEditable(context),
              SizedBox(height: MediaQuery.of(context).size.height / 3),
              TextButton(onPressed: () {}, child: Text('Save Changes')),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildInfoEditable(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: TextEditingController(text: 'Thomas Shelby'),
                decoration: InputDecoration(
                  labelText: 'Display Name',
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: TextFormField(
                controller: TextEditingController(text: 'Ahmed Bahaa Saied'),
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: TextEditingController(text: 'Thomas Shelby'),
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: TextFormField(
                controller: TextEditingController(text: 'Ahmed Bahaa Saied'),
                decoration: InputDecoration(
                  labelText: 'Secondary Email',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2 - 25.w,
          child: TextFormField(
            controller: TextEditingController(text: '+201206497455'),
            decoration: InputDecoration(
              labelText: 'Phone Number',
            ),
          ),
        ),
      ],
    );
  }

  CircleAvatar _buildAvatarImage() {
    return CircleAvatar(
      radius: 50.r,
      backgroundImage: AssetImage('assets/images/thomas_shelby.jpeg'),
    );
  }
}
