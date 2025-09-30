import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:mitra_pix/features/auth/presentation/components/my_text_field.dart';
import 'package:mitra_pix/features/profile/domain/entities/profile_user.dart';
import 'package:mitra_pix/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:mitra_pix/features/profile/presentation/cubit/profile_states.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileUser profileUser;
  const EditProfilePage({super.key, required this.profileUser});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // mobile image pick
  PlatformFile? imagePickedFile;

  // web pick image
  Uint8List? webImage;

  // pic Image
  Future<void> pickImage() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: kIsWeb);

    if (result != null) {
      setState(() {
        imagePickedFile = result.files.first;

        if (kIsWeb) {
          webImage = imagePickedFile!.bytes;
        }
      });
    }
  }

  final bioTextController = TextEditingController();

  // uplaod profile button pressed

  void uploadProfile() async {
    // profile cubit
    final profileCubit = context.read<ProfileCubit>();

    // prepare the images and data
    final String uid = widget.profileUser.uid;
    final String? newBio =
        bioTextController.text.isNotEmpty ? bioTextController.text : null;
    final imageMobilePath = kIsWeb ? null : imagePickedFile?.path;
    final imageWebBytes = kIsWeb ? imagePickedFile?.bytes : null;

    if (imagePickedFile != null || newBio != null) {
      profileCubit.updateProfile(
        uid: uid,
        newBio: newBio,
        imageMobilePath: imageMobilePath,
        imageWebBytes: imageWebBytes,
      );
    }
    // nothing to update -> go to previous page
    else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(builder: (context, state) {
      // profile loading
      if (state is ProfileLoading) {
        return const Scaffold(
            body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 10,
              ),
              Text("Uploading..."),
            ],
          ),
        ));
      } else {
        return buildEditPage();
      }
    }, listener: (context, state) {
      // if page loaded
      if (state is ProfileLoaded) {
        Navigator.pop(context);
      }
    });
  }

  Widget buildEditPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(onPressed: uploadProfile, icon: const Icon(Icons.upload))
        ],
      ),
      body: Column(
        children: [
          // profile picture
          Center(
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(100)),
              clipBehavior:  Clip.hardEdge,
              child:
                  // display selected image for mobile
                  (!kIsWeb && imagePickedFile != null)
                      ? Image.file(
                          File(imagePickedFile!.path!),
                          fit: BoxFit.cover,
                        )
                      :
                      // display selected image for web
                      (kIsWeb && webImage != null)
                          ? Image.memory(webImage!)
                          :
                          // no image selected -> display existing profile image
                          CachedNetworkImage(
                              imageUrl: widget.profileUser.profileImageUrl,
                              // loading
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),

                              // no image error
                              errorWidget: (context, url, error) => Icon(
                                Icons.person,
                                size: 72,
                                color: Theme.of(context).colorScheme.primary,
                              ),

                              // loaded
                              imageBuilder: (context, imageProvider) => Image(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
            ),
          ),

          // pick image button

          const SizedBox(
            height: 25,
          ),

          Center(
            child: MaterialButton(
              onPressed: pickImage,
              color: Colors.blue,
              child: Text("Pick Image"),
            ),
          ),

          // bio
          const Text("Bio"),

          const SizedBox(
            height: 25,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: MyTextField(
                controller: bioTextController,
                hintText: widget.profileUser.bio,
                obscureText: false),
          ),
        ],
      ),
    );
  }
}
