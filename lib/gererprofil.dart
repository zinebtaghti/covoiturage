import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileManagementScreen extends StatelessWidget {
  final ImagePicker picker = ImagePicker();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  ProfileManagementScreen({Key? key}) : super(key: key);

  Future<void> _pickImage(String purpose) async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    print("$purpose Image Selected: ${image?.path}");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion de Profil',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(backgroundColor: Colors.black),
        primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF039e8e)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF039e8e),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white12,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: Colors.white60),
          prefixIconColor: Color(0xFF039e8e),
          contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Gestion de Profil')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              buildSectionTitle('Informations Personnelles'),
              SizedBox(height: 20),
              buildTextField(controller: nameController, icon: Icons.person, hintText: 'Nom complet'),
              SizedBox(height: 20),
              buildTextField(controller: emailController, icon: Icons.email, hintText: 'Adresse email', keyboardType: TextInputType.emailAddress),
              SizedBox(height: 20),
              buildTextField(controller: phoneController, icon: Icons.phone, hintText: 'Numéro de téléphone', keyboardType: TextInputType.phone),
              SizedBox(height: 20),
              Divider(color: Colors.grey[700]),
              buildSectionTitle('Informations sur le Véhicule'),
              SizedBox(height: 20),
              buildTextField(icon: Icons.directions_car, hintText: 'Marque du véhicule'),
              SizedBox(height: 20),
              buildTextField(icon: Icons.event_seat, hintText: 'Nombre de places'),
              SizedBox(height: 20),
              buildTextField(icon: Icons.featured_video, hintText: 'Plaque d\'immatriculation'),
              SizedBox(height: 20),
              Divider(color: Colors.grey[700]),
              buildSectionTitle('Informations sur le Permis de Conduire'),
              SizedBox(height: 20),
              _buildButton(context, 'Insérer votre photo d\'identité', Icons.image),
              SizedBox(height: 20),
              _buildButton(context, 'Insérer le recto de votre permis', Icons.image),
              SizedBox(height: 20),
              _buildButton(context, 'Ajouter le verso de votre permis', Icons.image),
              SizedBox(height: 30),
              Divider(color: Colors.grey[700]),
              _buildRoundedButton(context, 'Enregistrer', Color(0xFF039e8e), Colors.black),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({TextEditingController? controller, required IconData icon, required String hintText, TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Color(0xFF039e8e)),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white60),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white12,
      ),
      keyboardType: keyboardType,
      style: TextStyle(color: Colors.white),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  Widget _buildButton(BuildContext context, String text, IconData icon) {
    return Container(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Color(0xFF039e8e)),
        label: Text(text.trim(), style: TextStyle(color: Colors.white60)),
        onPressed: () => _pickImage(text),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.white12,
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
          padding: EdgeInsets.symmetric(vertical: 18.0),
          elevation: 0,
        ),
      ),
    );
  }

  Widget _buildRoundedButton(BuildContext context, String text, Color backgroundColor, Color textColor) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
          padding: const EdgeInsets.symmetric(vertical: 20.0),
        ),
        onPressed: () {},
        child: Text(text, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
