import 'package:flutter/material.dart';
import 'package:techincal_test_flutter/model/user_model.dart';

class ListDataWidget extends StatelessWidget {
  const ListDataWidget({
    super.key,
    required this.userData,
  });

  final UserModel userData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          visualDensity: const VisualDensity(
            horizontal: 0,
            vertical: -4,
          ),
          title: Text(userData.name),
          subtitle: Text(userData.email),
          trailing: userData.verified
              ? const Icon(Icons.verified_rounded)
              : const SizedBox(),
        ),
        const Divider(),
      ],
    );
  }
}
