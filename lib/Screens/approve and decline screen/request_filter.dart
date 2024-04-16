import 'package:flutter/material.dart';
import 'package:mygovern/Screens/approve%20and%20decline%20screen/request_details.dart';
import 'package:mygovern/models/request.dart';

enum REQUEST {
  STATUS_PENDING,
  STATUS_APPROVE,
  STATUS_DECLINED,
}

class RequestFilterScreen extends StatelessWidget {
  final List<DocRequest> docRequest;
  final bool isApprove;
  const RequestFilterScreen(this.isApprove, this.docRequest, {super.key});

  @override
  Widget build(BuildContext context) {
    var requests = [];
    if (isApprove) {
      requests = docRequest
          .where((element) => element.status == REQUEST.STATUS_APPROVE)
          .toList();
    } else {
      requests = docRequest
          .where((element) => element.status == REQUEST.STATUS_DECLINED)
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isApprove ? 'Approved' : 'Declined'),
        backgroundColor: isApprove ? Colors.green : Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: requests.isEmpty
            ? const Center(
                child: Text('Empty'),
              )
            : ListView.builder(
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RequestDetails(requests[index]),
                          ),
                        );
                      },
                      title: Text(requests.elementAt(index).request),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: isApprove ? Colors.green : Colors.redAccent,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
