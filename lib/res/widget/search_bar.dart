import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:tedza/constants/constant.dart';

class PPSearchBox extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final bool? isEnabled;
  final String? hintText;
  final TextEditingController textEditingController;
  final VoidCallback clearField;

  const PPSearchBox(
      {this.onChanged,
      this.hintText,
      this.isEnabled,
      Key? key,
      required this.textEditingController,
      required this.clearField})
      : super(key: key);

  @override
  State<PPSearchBox> createState() => _BPSearchBoxState();
}

class _BPSearchBoxState extends State<PPSearchBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: kWhite,
          border: Border.all(color: AppColor.kGreyNeutral.shade300),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: TextField(
                enabled: widget.isEnabled,
                onChanged: widget.onChanged,
                controller: widget.textEditingController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintStyle: const TextStyle(
                    color: kGrey,
                  ),
                  hintText: widget.hintText,
                  suffixIcon: widget.textEditingController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () => widget.clearField(),
                          icon: Icon(
                            FontAwesomeIcons.solidCircleXmark,
                            size: 15,
                            color: AppColor.kGreyNeutral.shade500,
                          ))
                      : null,
                ),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Icon(
                IconlyLight.search,
                color: kGrey,
                size: kPaddingXL,
              ),
            ),
          ],
        ));
  }
}
