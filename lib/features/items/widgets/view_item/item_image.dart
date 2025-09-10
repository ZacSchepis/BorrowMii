
import 'package:borrow_mii/data/repositories/item_repository.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItemImage();
  }

  Future<String?> getItemImage() async {
    // final i = widget.itemId;
    String? img = await _imgRepo.getImageFromGCS(widget.itemId);
        print("Img: $img");
    setState(() {
      if(img != null) {
          _imgUrl = img;
          _loaded = img != null;
      }
    });
    return img;
  }
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250, width: 250, 
      child: !_loaded 
              ? const Center(child: CircularProgressIndicator())
              : Image.network(_imgUrl!, fit: BoxFit.cover,
                errorBuilder: (ctx, err, trace) => const Icon(Icons.broken_image),
              )
    );


    }
}