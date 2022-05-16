import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio_bloc_imagepicker/model/model.dart';
import 'package:dio_bloc_imagepicker/page/information_page.dart';
import 'package:dio_bloc_imagepicker/constants/constants.dart';
import 'package:dio_bloc_imagepicker/bloc/api_bloc/api_bloc.dart';
import 'package:dio_bloc_imagepicker/bloc/imagepicker_bloc/image_picker_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ImagePickerBloc()),
          BlocProvider(create: (context) => ApiBloc()),
        ],
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: const [
              ImageWidget(),
              SearchWidget(),
              ImagePostWidget(),
              Padding(
                padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                child: Text('Posts', style: AppTextStyle.homeTextStyle),
              ),
              PostPageView()
            ],
          ),
        ),
      ),
    );
  }
}

class ImageWidget extends StatefulWidget {
  const ImageWidget({Key? key}) : super(key: key);

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final imagePickerBloc = BlocProvider.of<ImagePickerBloc>(context);

    return Column(
      children: [
        Center(
          child: ClipOval(
              child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                        height: 150,
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text('Camera'),
                              onTap: () async {
                                Navigator.of(context).pop();

                                imagePickerBloc
                                    .add(SelectImageEvent(ImageSource.camera));
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.image),
                              title: const Text('Gallery'),
                              onTap: () async {
                                Navigator.of(context).pop();
                                imagePickerBloc
                                    .add(SelectImageEvent(ImageSource.gallery));
                              },
                            )
                          ],
                        ),
                      ));
            },
            child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
              builder: (context, state) => state.image != null
                  ? Image.file(
                      File(state.image!.path),
                      fit: BoxFit.cover,
                      cacheHeight: 160,
                      cacheWidth: 160,
                    )
                  : Image.asset(
                      'images/intro.jpg',
                      fit: BoxFit.cover,
                      cacheHeight: 160,
                      cacheWidth: 160,
                    ),
            ),
          )),
        ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Center(
              child:
                  Text('Truong Phuoc Tin', style: AppTextStyle.homeTextStyle)),
        ),
      ],
    );
  }
}

class ImagePostWidget extends StatefulWidget {
  const ImagePostWidget({Key? key}) : super(key: key);

  @override
  State<ImagePostWidget> createState() => _ImagePostWidgetState();
}

class _ImagePostWidgetState extends State<ImagePostWidget> {
  @override
  Widget build(BuildContext context) {
    final imagePickerBloc = BlocProvider.of<ImagePickerBloc>(context);

    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => Container(
                  height: 150,
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.camera_alt),
                        title: const Text('One'),
                        onTap: () async {
                          Navigator.of(context).pop();
                          imagePickerBloc
                              .add(SelectImageEvent(ImageSource.gallery));
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.image),
                        title: const Text('Multi'),
                        onTap: () async {
                          Navigator.of(context).pop();
                          imagePickerBloc.add(SelectMultiImageEvent());
                        },
                      )
                    ],
                  ),
                ));
      },
      child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
          builder: (context, state) => state.image != null
              ? Container(
                height: 200,
                child: Image.file(
                    File(state.image!.path),
                    fit: BoxFit.cover,
                    cacheHeight: 160,
                    cacheWidth: 160,
                  ),
              )
              : state.lstImage != null
                  ? Container(
                      height: 200,
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemCount: state.lstImage?.length,
                          itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(5),
                                child: Image.file(
                                  File(state.lstImage![index].path),
                                  fit: BoxFit.cover,
                                  cacheHeight: 160,
                                  cacheWidth: 160,
                                ),
                              )))
                  : TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                                  height: 150,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.image),
                                        title: const Text('Chọn 1 ảnh'),
                                        onTap: () async {
                                          Navigator.of(context).pop();
                                          imagePickerBloc.add(SelectImageEvent(
                                              ImageSource.gallery));
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.image),
                                        title: const Text('Chọn nhiều ảnh'),
                                        onTap: () async {
                                          Navigator.of(context).pop();
                                          imagePickerBloc
                                              .add(SelectMultiImageEvent());
                                        },
                                      )
                                    ],
                                  ),
                                ));
                      },
                      child: const Text('Thêm ảnh', style: TextStyle(fontSize: 20),))),
    );
  }
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController searchController = TextEditingController();
  bool check = false;

  @override
  Widget build(BuildContext context) {
    final apiBloc = BlocProvider.of<ApiBloc>(context);

    return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: BlocBuilder<ApiBloc, ApiState>(
            builder: (context, state) => check == false
                ? Stack(
                    alignment: Alignment.centerRight,
                    children: <Widget>[
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: 'Search for post ...',
                          hoverColor: AppColors.mainColor,
                        ),
                      ),
                      Positioned(
                        right: 10,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.mainColor,
                                )
                              ]),
                          child: IconButton(
                            icon:
                                Icon(Icons.search, color: AppColors.whiteColor),
                            onPressed: () {
                              setState(() {
                                if (searchController.text != '') {
                                  check = true;
                                  apiBloc.add(
                                      getPostFetchEvent(searchController.text));
                                  searchController.text = '';
                                } else {
                                  check = false;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Stack(
                        alignment: Alignment.centerRight,
                        children: <Widget>[
                          TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'Search for post ...',
                              hoverColor: AppColors.mainColor,
                            ),
                          ),
                          Positioned(
                            right: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.mainColor,
                                    )
                                  ]),
                              child: IconButton(
                                icon: Icon(Icons.search,
                                    color: AppColors.whiteColor),
                                onPressed: () {
                                  setState(() {
                                    if (searchController.text != '') {
                                      check = true;
                                      apiBloc.add(getPostFetchEvent(
                                          searchController.text));
                                      searchController.text = '';
                                    } else {
                                      check = false;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            height: 180,
                            width: double.infinity,
                            color: Colors.grey[100],
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('ID: ${state.post?.id.toString()}'),
                                  Text(
                                      'UserID: ${state.post?.userId.toString()}'),
                                  Text('Title: ${state.post?.title}'),
                                  Text('Body: ${state.post?.body}'),
                                ],
                              ),
                            )),
                      ),
                    ],
                  )));
  }
}

class PostPageView extends StatefulWidget {
  const PostPageView({Key? key}) : super(key: key);

  @override
  State<PostPageView> createState() => _PostPageViewState();
}

class _PostPageViewState extends State<PostPageView> {
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    final apiBloc = BlocProvider.of<ApiBloc>(context);
    apiBloc.add(getPostEvent());
    return BlocProvider(
        create: (context) => ApiBloc()..add(getPostEvent()),
        child: BlocBuilder<ApiBloc, ApiState>(
            builder: (context, state) => Container(
                  height: 400,
                  width: double.infinity,
                  child: ListView.builder(
                      // scrollDirection: Axis.horizontal,
                      controller: controller,
                      itemCount: state.lstPost?.length ?? 0,
                      itemBuilder: (context, index) =>
                          PostItem(state.lstPost![index])),
                )));
  }
}

class PostItem extends StatelessWidget {
  final Post post;
  PostItem(this.post);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
          child: Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                  // width: 200,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('ID Post: ${post.id.toString()}'),
                        subtitle: Text(post.title.toString()),
                      ),
                    ],
                  )))),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return InformationPageWidget(post: post);
        }),
      ),
    );
  }
}
