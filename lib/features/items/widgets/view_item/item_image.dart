
import 'package:borrow_mii/data/repositories/item_repository.dart';
import 'package:borrow_mii/data/repositories/storage_repository.dart';
import 'package:borrow_mii/widgets/loading_modal.dart';
import 'package:flutter/material.dart';

class ItemImage extends StatefulWidget{
  final String itemId;
  const ItemImage({
    super.key,
    required this.itemId
  });

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
    if(widget.itemId.isNotEmpty) {
      String? img = await _storage.getImageFromGCS(widget.itemId);
      setState(() {
        final i = img;
        if(i != null) {
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
    return FutureBuilder(future: ()async  {
      final imgPath = await _storage.getImageFromGCS(widget.itemId);
      if(imgPath == null || imgPath.isEmpty) throw Exception("Image unavailable");
      final img = Image.network(imgPath, fit: BoxFit.cover);
      return img;
    }(), builder: (context, AsyncSnapshot<Image?> snapshot) {
      if(snapshot.hasError) {
        return Text("Image unavailable");
      }
      if(snapshot.connectionState == ConnectionState.waiting) {
        return LoadingModal(loaded: false);
      }
      if(snapshot.hasData) {
        final r = snapshot.data;
        if(r == null) return Text("Image unavailable");
        return SizedBox(height: 250, width: 250, child: r,);
      }
      return Text("Image unvailable");
    });
    // return SizedBox(
    //   height: 250, width: 250, 
    //   child: !_loaded 
    //           ? const Center(child: CircularProgressIndicator())
    //           : Image.network(_imgUrl!, fit: BoxFit.cover,
    //             errorBuilder: (ctx, err, trace) => const Icon(Icons.broken_image),
    //           )
    // );


    }
}