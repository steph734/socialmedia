import 'package:flutter/material.dart';
import 'package:socialmedia_clone/model/userdata.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key, required Userdata userdata});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController(
    text: "Maricel Joy Alajar",
  );
  final TextEditingController _usernameController = TextEditingController(
    text: "mariceljoy",
  );
  final TextEditingController _bioController = TextEditingController(
    text: "Dream. Explore. Inspire.",
  );
  final TextEditingController _emailController = TextEditingController(
    text: "mariceljoyalajar@gmail.com",
  );
  final TextEditingController _genderController = TextEditingController(
    text: "Female",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Edit Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // TODO: Save to userdata / database
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Profile updated")),
                );
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(height: 20),

            // Profile Photo
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/user1.jpg"),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Pick new image
                    },
                    child: const Text(
                      "Change Profile Photo",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(),

            // Name
            _buildTextField("Name", _nameController),

            // Username
            _buildTextField("Username", _usernameController),

            // Bio
            _buildTextField("Bio", _bioController, maxLines: 2),

            const Divider(),

            // Email
            _buildTextField("Email", _emailController),

            // Gender
            _buildTextField("Gender", _genderController),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          border: const UnderlineInputBorder(),
        ),
        validator: (value) => value!.isEmpty ? "$label cannot be empty" : null,
      ),
    );
  }
}
