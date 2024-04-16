import 'package:flutter/material.dart';
import 'package:mygovern/Screens/approve%20and%20decline%20screen/request_filter.dart';
import 'package:mygovern/models/request.dart';

class RequestDetails extends StatelessWidget {
  final DocRequest docRequest;
  const RequestDetails(this.docRequest, {super.key});

  String getStatus() {
    switch (docRequest.status) {
      case REQUEST.STATUS_APPROVE:
        return "Approve";
      case REQUEST.STATUS_DECLINED:
        return "Declined";
      default:
        return "Under Review";
    }
  }

  Widget decaratedText(Widget textWidget) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: textWidget,
    );
  }

  Widget tableHeading(String text) {
    return Expanded(
        child: Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ));
  }

  Widget tableContent(String text) {
    return Expanded(
        child: Text(
      text,
      style: const TextStyle(
        fontSize: 15,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Details'),
        ),
        body: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  tableHeading("Title"),
                  tableHeading("Details"),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  tableContent("Request"),
                  tableContent(docRequest.request),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  tableContent("Request Id :"),
                  tableContent(docRequest.requestId),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  tableContent("Status : "),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: getStatus() == "Approve"
                            ? Colors.green.shade400
                            : Colors.redAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        getStatus(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              const Divider(),
              Row(
                children: [
                  tableContent("Message : "),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(docRequest.message.isEmpty
                          ? "None"
                          : docRequest.message),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
