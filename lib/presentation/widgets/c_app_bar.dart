import 'package:flutter/material.dart';
import 'package:digital14/presentation/widgets/c_app_bar_consts.dart';

class CAppBarSwitcher extends StatelessWidget implements PreferredSizeWidget {
  final bool isPrimary;
  final CAppBar primary;
  final CAppBar secondary;

  const CAppBarSwitcher({
    Key? key,
    required this.primary,
    required this.secondary,
    this.isPrimary = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 5),
      switchInCurve: Curves.bounceInOut,
      switchOutCurve: Curves.easeOutCirc,
      child: isPrimary ? primary : secondary,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CAppBar extends SizedBox implements PreferredSizeWidget {
  //Home AppBar
  CAppBar.home(
    BuildContext context, {
    Key? key,
    required final String title,
    required final VoidCallback onSearchPressed,
  }) : super(
          key: key,
          child: AppBar(
            title: Text(title),
            actions: [
              IconButton(
                onPressed: onSearchPressed,
                icon: const Icon(Icons.search),
              )
            ],
          ),
        );

  CAppBar.search(
    BuildContext context, {
    Key? key,
    required final VoidCallback onCancelPressed,
    required final Function(String value) onTextEntered,
    final FocusNode? focusNode,
  }) : super(
          key: key,
          child: AppBar(
            title: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: TextField(
                  focusNode: focusNode,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.arrow_forward, color: Colors.black),
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    hintText: CAppBarConsts.search,
                    border: InputBorder.none,
                    //iconColor: Colors.black
                  ),
                  onChanged: onTextEntered,
                ),
              ),
            ),
            actions: [
              Center(
                child: SizedBox(
                  height: 40,
                  child: TextButton(
                    onPressed: onCancelPressed,
                    child: Text(CAppBarConsts.cancel,
                        style: TextStyle(color: Colors.lime[800])),
                  ),
                ),
              ),
              const SizedBox(width: 16)
            ],
          ),
        );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
