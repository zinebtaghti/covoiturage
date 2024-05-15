import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileManagementScreen extends StatefulWidget {
  const ProfileManagementScreen({Key? key}) : super(key: key);

  @override
  _ProfileManagementScreenState createState() => _ProfileManagementScreenState();
}

class _ProfileManagementScreenState extends State<ProfileManagementScreen> {
  final ImagePicker picker = ImagePicker();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool _isDriver = false; // Indicateur si l'utilisateur est conducteur ou non

  @override
  void initState() {
    super.initState();
    // Pré-remplir les champs de texte à partir de Firestore
    _fetchUserData();
  }


  Future<void> _fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        Map<String, dynamic> userData = {}; // Définir userData en dehors du bloc if
        if (userDoc.exists) {
          userData = userDoc.data() as Map<String, dynamic>;
          setState(() {
            nameController.text = userData['name'] ?? ''; // Assurez-vous que la clé dans Firestore est 'name'
            emailController.text = userData['email'] ?? user.email ?? '';
            phoneController.text = userData['phone'] ?? '';
          });
        } else {
          // Utiliser le nom de l'utilisateur actuel s'il n'existe pas dans Firestore
          setState(() {
            nameController.text = user.displayName ?? '';
            emailController.text = user.email ?? '';
          });
        }
      }
    } catch (e) {
      print('Erreur lors de la récupération des données de l\'utilisateur: $e');
    }
  }





  Future<void> _pickImage(String purpose) async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    print("$purpose Image Selected: ${image?.path}");
  }


  Future<void> _saveProfileInfo() async {
    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String phone = phoneController.text.trim();

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;
        Map<String, dynamic> userData = {
          if (name.isNotEmpty) 'name': name,
          if (email.isNotEmpty) 'email': email,
          if (phone.isNotEmpty) 'phone': phone,
        };

        await FirebaseFirestore.instance.collection('users').doc(userId).set(userData, SetOptions(merge: true));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Informations enregistrées avec succès.'),
          ),
        );
      }
    } catch (e) {
      print('Erreur lors de l\'enregistrement des informations de l\'utilisateur: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Une erreur s\'est produite lors de l\'enregistrement des informations. Veuillez réessayer.'),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    print('Texte du champ du nom: ${nameController.text}');
    print('Texte du champ de l\'email: ${emailController.text}');
    print('Texte du champ du téléphone: ${phoneController.text}');
    return Scaffold(
      appBar: AppBar(title: Text('Gestion de Profil',style: TextStyle(color: Colors.white)),backgroundColor: Colors.black,),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            // Autres champs et boutons
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _saveProfileInfo(),
        backgroundColor: Colors.grey[900],
        child: Icon(Icons.save,color: Color(0xFF039e8e)),
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
          foregroundColor: Colors.white,
          backgroundColor: Colors.white12,
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
        onPressed: () => _saveProfileInfo(),
        child: Text(text, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

