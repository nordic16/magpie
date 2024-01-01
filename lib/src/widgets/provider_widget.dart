
import 'package:flutter/material.dart';

import 'package:magpie/src/activities/provider_activity.dart';
import 'package:magpie/src/providers/provider.dart';

class ProviderWidget extends StatelessWidget {
  final Provider provider;

  const ProviderWidget(this.provider, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProviderActivity(provider),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Image(
              image: Image.network(provider.logoUrl).image,
              width: 50,
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Text(
                    provider.name
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
