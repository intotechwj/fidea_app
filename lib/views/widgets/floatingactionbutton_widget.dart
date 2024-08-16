import 'package:fidea_app/text/apptext.dart';
import 'package:fidea_app/views/pages/newnote_page.dart';
import 'package:flutter/material.dart';

class CustomFloatingActionButtonWidget extends StatelessWidget {
  const CustomFloatingActionButtonWidget({super.key});

  void _showPageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('${TextCRUD.newNote} ${ TextCRUD.createNote}'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                _buildPageOption(context, PagesFidea.focus, '${PagesFidea.focus} ${TextCRUD.createNote}'),
                _buildPageOption(context, PagesFidea.control, '${ PagesFidea.control} ${TextCRUD.createNote}'),
                _buildPageOption(context, PagesFidea.plan, '${PagesFidea.plan} ${TextCRUD.createNote}'),
                _buildPageOption(context, PagesFidea.start, '${PagesFidea.start} ${TextCRUD.createNote}'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPageOption(BuildContext context, String pageType, String title) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewnotePage(
              pageType: pageType,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        width: 130,
        height: 40,
        child: FilledButton(
          onPressed: () => _showPageSelectionDialog(context),
          style: ButtonStyle(
            padding: WidgetStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(TextCRUD.newNote),
              SizedBox(width: 8),
              Icon(Icons.add),
            ],
          ),
        ),
      ),
    );
  }
}
