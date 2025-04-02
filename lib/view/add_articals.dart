
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({Key? key}) : super(key: key);

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  // final BlogController blogController = Get.find<BlogController>();
  // final AuthController authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  final HtmlEditorController _htmlController = HtmlEditorController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  dynamic _selectedImage;
  bool _isSubmitting = false;
  bool _useSimpleEditor = true;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      maxHeight: 720,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() => _selectedImage = image);
    }
  }

  Future<void> _submitBlog() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedImage == null) {
      Get.snackbar('Error', 'Please select a cover image',
          backgroundColor: Colors.transparent);
      return;
    }

    setState(() => _isSubmitting = true);

    // try {
    //   final content = _useSimpleEditor
    //       ? _contentController.text.trim()
    //       : (await _htmlController.getText()) ?? '';
    //
    //   if (content.isEmpty) {
    //     Get.snackbar('Error', 'Please add some content',
    //         backgroundColor: Colors.red[100]);
    //     return;
    //   }
    //
    //   await blogController.createBlog(
    //     title: _titleController.text.trim(),
    //     content: content,
    //     imagePath: _selectedImage,
    //     authorId: authController.user.value!.$id,
    //     authorName: authController.user.value!.name,
    //   );
    // } catch (e) {
    //   Get.snackbar('Error', 'Failed to create blog post',
    //       backgroundColor: Colors.red[100]);
    // } finally {
    //   setState(() => _isSubmitting = false);
    // }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: SizedBox(
              width: screenWidth * 0.9,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                          labelText: 'Title', border: OutlineInputBorder()),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter a title' : null,
                    ),
                    const SizedBox(height: 12),
                    TextButton.icon(
                      onPressed: _isSubmitting ? null : _pickImage,
                      icon: const Icon(Icons.image, color: Colors.black),
                      label: const Text('Select Cover Image'),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                      ),
                    ),
                    if (_selectedImage != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Image selected: ${kIsWeb ? _selectedImage.name : _selectedImage.path.split('/').last}',
                          style: const TextStyle(color: Colors.green),
                        ),
                      ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Content',
                            style: Theme.of(context).textTheme.titleMedium),
                        TextButton.icon(
                          onPressed: () =>
                              setState(() => _useSimpleEditor = !_useSimpleEditor),
                          icon: Icon(_useSimpleEditor ? Icons.edit_note : Icons.edit),
                          label: Text(
                              _useSimpleEditor ? 'Rich Editor' : 'Simple Editor'),
                        ),
                      ],
                    ),
                    _useSimpleEditor
                        ? SizedBox(
                      height: 200,
                      child: TextFormField(
                        controller: _contentController,
                        maxLines: 8,
                        decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter content' : null,
                      ),
                    )
                        : SizedBox(
                      height: 200,
                      child: HtmlEditor(
                        controller: _htmlController,
                        htmlEditorOptions: const HtmlEditorOptions(
                            hint: 'Write your blog post...'),
                        htmlToolbarOptions: const HtmlToolbarOptions(
                          defaultToolbarButtons: [
                            StyleButtons(),
                            FontButtons(),
                            ColorButtons(),
                            ListButtons(),
                            ParagraphButtons(),
                            InsertButtons(picture: false),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton.icon(
                        onPressed: _isSubmitting ? null : _submitBlog,
                        icon: _isSubmitting
                            ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                            : const Icon(Icons.cloud_upload),
                        label: Text(
                          _isSubmitting ? 'Uploading...' : 'Upload Post',
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                        ),
                      ),
                    ),
                    // const SizedBox(height: 10),
                    // const AppFooter(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
