import 'package:borrow_mii/data/repositories/item_repository.dart';
import 'package:borrow_mii/data/repositories/storage_repository.dart';
import 'package:borrow_mii/widgets/loading_modal.dart';
import 'package:flutter/material.dart';

class ItemImage extends StatefulWidget {
  final String itemId;
  final double width;
  final double height;
  final bool isGCSImage;
  const ItemImage(
      {super.key, required this.itemId, this.height = 250, this.width = 250, this.isGCSImage = true});

  @override
  State<ItemImage> createState() => _ItemImageWidgetState();
}

class _ItemImageWidgetState extends State<ItemImage> {
  bool _loaded = false;
  String? _imgUrl;
  ImageRepository _imgRepo = ImageRepository();
  final StorageRepository _storage = StorageRepository();

  @override
  void initState() {
    super.initState();
    getItemImage();
  }

  Future<String?> getItemImage() async {
    // final i = widget.itemId;
    if(!widget.isGCSImage ) {
      final url = widget.itemId;
      if(url == null || url.isEmpty) return "";
      setState(() {
        _imgUrl = url;
        _loaded = url.isEmpty;
      });
      return _imgUrl;
    }
    if (widget.itemId.isNotEmpty) {
      String? img = await _storage.getImageFromGCS(widget.itemId);
      setState(() {
        final i = img;
        if (i != null) {
          _imgUrl = img;
          _loaded = i.isEmpty;
        }
      });
      return img;
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    // final parentBox = ;
    return FutureBuilder(future: () async {
      final imgPath = await getItemImage();
      if (imgPath == null || imgPath.isEmpty)
        throw Exception("Image unavailable");
      final img = Image.network(imgPath, fit: BoxFit.cover);
      return img;
    }(), builder: (context, AsyncSnapshot<Image?> snapshot) {
      if (snapshot.hasError) {
        return SizedBox(
          width: widget.width,
          height: widget.height,
          
          child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey)),
        );
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return LoadingModal(loaded: false, width: widget.width, height: widget.height,);
      }
      if (snapshot.hasData) {
        final r = snapshot.data;
        if (r == null) return Text("Image unavailable");
        return SizedBox(
          height: widget.height,
          width: widget.width,
          child: r,
        );
      }
      return Text("Image unvailable");
    });
  }
}
