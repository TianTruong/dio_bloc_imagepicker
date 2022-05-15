
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio_bloc_imagepicker/model/model.dart';
import 'package:dio_bloc_imagepicker/constants/constants.dart';
import 'package:dio_bloc_imagepicker/bloc/api_bloc/api_bloc.dart';

class InformationPageWidget extends StatefulWidget {
  final Post post;
  const InformationPageWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<InformationPageWidget> createState() => _InformationPageWidgetState();
}

class _InformationPageWidgetState extends State<InformationPageWidget> {
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
        body: BlocProvider(
          create: (context) => ApiBloc(),
          child: ListView(children: [
            const AppbarWidget(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InformationWidget(post: widget.post),
                  UpdateWidget(post: widget.post),
                ],
              ),
            ),
          ]),
        ),
        bottomNavigationBar: BlocProvider(
          create: (context) => ApiBloc(),
          child: DeleteWidget(post: widget.post)
        ),
            );
  }
}
class AppbarWidget extends StatefulWidget {
  const AppbarWidget({Key? key}) : super(key: key);

  @override
  State<AppbarWidget> createState() => _AppbarWidgetState();
}
class _AppbarWidgetState extends State<AppbarWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15)),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: AppColors.blackColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15)),
            child: IconButton(
              icon: Icon(Icons.search, color: AppColors.blackColor),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
class InformationWidget extends StatefulWidget {
  final Post post;
  const InformationWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<InformationWidget> createState() => _InformationWidgetState();
}
class _InformationWidgetState extends State<InformationWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              const Text('ID: ', style: AppTextStyle.homeTextStyle),
              Text(widget.post.id.toString(),
                  style: AppTextStyle.homeTextStyle),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Text(widget.post.title,
              style: const TextStyle(fontSize: 18, color: Colors.black)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Text('Body: ',
              style: TextStyle(color: Colors.grey[700], fontSize: 16)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Text(widget.post.body,
              style: TextStyle(color: Colors.grey[700], fontSize: 16)),
        ),
      ],
    );
  }
}
class UpdateWidget extends StatefulWidget {
  final Post post;
  const UpdateWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<UpdateWidget> createState() => _UpdateWidgetState();
}
class _UpdateWidgetState extends State<UpdateWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final apiBloc = BlocProvider.of<ApiBloc>(context);

    return BlocListener<ApiBloc, ApiState>(
      listener: (context, state) {
        if (state.updatePost != null) {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('ID: ${state.updatePost?.id.toString()}'),
                      Text('Title: ${state.updatePost?.title}'),
                      Text('Body: ${state.updatePost?.body}'),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
      child: BlocBuilder<ApiBloc, ApiState>(
        builder: (context, state) {
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 25, bottom: 5),
                child: Text('Update: ', style: AppTextStyle.homeTextStyle),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Title',
                    hoverColor: AppColors.mainColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: TextField(
                  controller: bodyController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Body',
                    hoverColor: AppColors.mainColor,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text != '' && bodyController.text != '') {
                    PostInfo postInfo = PostInfo(
                      title: titleController.text,
                      body: bodyController.text,
                    );

                    apiBloc.add(
                        updatePostEvent(postInfo, widget.post.id.toString()));
                  }
                },
                child: const Text('Update post', style: TextStyle(fontSize: 20.0)),
              ),
            ],
          );
        },
      ),
    );
  }
}
class DeleteWidget extends StatefulWidget {
  final Post post;
  const DeleteWidget({ Key? key,required this.post }) : super(key: key);

  @override
  State<DeleteWidget> createState() => _DeleteWidgetState();
}
class _DeleteWidgetState extends State<DeleteWidget> {

  @override
  Widget build(BuildContext context) {
    final apiBloc = BlocProvider.of<ApiBloc>(context);
    
    return BlocBuilder<ApiBloc, ApiState>(
        builder: (context, state) {
          return BottomAppBar(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 30,
                width: double.infinity,
                child: IconButton(
                  icon: Icon(Icons.delete, color: AppColors.whiteColor),
                  onPressed: () async {
                    apiBloc.add(
                        deletePostEvent(widget.post.id.toString()));
                    // await postClient.deletePost(id: widget.post.id.toString());
                    final snackBar = SnackBar(
                      content: Text(
                        'Post at id ${widget.post.id} deleted!',
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                ),
              ),
            ));
        },
      );
    
  }
}