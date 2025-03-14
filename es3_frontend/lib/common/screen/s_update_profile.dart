import 'package:es3_frontend/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'email',
            style: TextStyle(
              color: GRAY1_COLOR,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('abcd012@gmail.com'),
              IconButton(
                onPressed: () => showDialog<String>(
                    context: context,
                    builder: (context) => _textDialog('Update Email')),
                icon: Icon(Icons.edit),
              ),
            ],
          ),
          Divider(),
          Text(
            'name',
            style: TextStyle(
              color: GRAY1_COLOR,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('lee eunseo'),
              IconButton(
                onPressed: () => showDialog<String>(
                    context: context,
                    builder: (context) => _textDialog('Update Name')),
                icon: Icon(Icons.edit),
              ),
            ],
          ),
          Divider(),
          Text(
            'password',
            style: TextStyle(
              color: GRAY1_COLOR,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('********'),
              IconButton(
                onPressed: () => showDialog<String>(
                    context: context,
                    builder: (context) => _passwordDialog('Update Password')),
                icon: Icon(Icons.edit),
              ),
            ],
          ),
          Divider(),
          Text(
            'mobile',
            style: TextStyle(
              color: GRAY1_COLOR,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('01082464487'),
              IconButton(
                onPressed: () => showDialog<String>(
                    context: context,
                    builder: (context) => _textDialog('Update Mobile')),
                icon: Icon(Icons.edit),
              ),
            ],
          ),
          Divider(),
          Text(
            'birth day',
            style: TextStyle(
              color: GRAY1_COLOR,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('2000.04.15'),
              IconButton(
                onPressed: () => showDialog<DateTime>(
                    context: context,
                    builder: (context) => DatePickerDialog(firstDate: DateTime(2000), lastDate: DateTime(2006),)),
                icon: Icon(Icons.edit),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Dialog _textDialog(String title) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(title),
            const SizedBox(height: 15),
            const TextField(),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text('Update'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Dialog _passwordDialog(String title) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(title),
            const SizedBox(height: 15),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'current password',
                labelText: 'current password',
              ),
            ),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'new password',
                labelText: 'new password',
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'connfirm new password',
                labelText: 'cocnfirm new password',
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text('Update'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Dialog _dateTimeDialog(String title) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(title),
            const SizedBox(height: 15),
            // const TextField(),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text('Update'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
