class FileItem {
  String? created;
  String? pdfUrl;

  FileItem({
    this.created,
    this.pdfUrl,
  });

  FileItem.fromJson(Map<String, dynamic> json) {
    created = json['created'];

    pdfUrl = json['pdfUrl'] ?? json['file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created'] = this.created;
    data['pdfUrl'] = this.pdfUrl;
    return data;
  }
}
