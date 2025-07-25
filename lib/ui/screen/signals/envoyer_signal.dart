import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:safe_guinee/services/probleme/probleme_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe_guinee/utils/location_service.dart';
import 'package:universe/universe.dart';
// import 'package:safe_guinee/models/probleme.dart';

class NouveauSignalement extends StatefulWidget {
  const NouveauSignalement({super.key});

  @override
  State<NouveauSignalement> createState() => _NouveauSignalementState();
}

class _NouveauSignalementState extends State<NouveauSignalement> {
  String? selectedProbleme;
  String imagePath = "";
  File? imagefile;
  double long = -6.175329;
  double lat = 106.827253;
  TextEditingController addresseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Type de problème"),
            const SizedBox(height: 8),

            // 🔄 StreamBuilder pour écouter les problèmes Firestore
            StreamBuilder<QuerySnapshot>(
              stream: ProblemeService().getAllProblemes(),
              builder: (context, snapshot) {
                // if (snapshot.hasError)
                //   return Text("Erreur : ${snapshot.error}");
                if (!snapshot.hasData) return CircularProgressIndicator();

                final problemes = snapshot.data!.docs;

                return DropdownButtonFormField<String>(
                  value: selectedProbleme,
                  items:
                      problemes.map((doc) {
                        final p = doc.data();
                        return DropdownMenuItem<String>(
                          value: p.toString(),
                          child: Text(
                            p.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedProbleme = value;
                    });
                  },
                  dropdownColor: const Color.fromARGB(255, 167, 167, 167),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            const Text("Description"),
            const SizedBox(height: 8),
            TextField(
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "Décrivez brièvement le problème...",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: (imagefile != null) ? 200 : 10,
                  child:
                      (imagefile != null)
                          ? Image.file(imagefile!, fit: BoxFit.cover)
                          : SizedBox(),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => takePicture(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text("Caméra"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => takePicture(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library),
                      label: const Text("Galerie"),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text("Localisation"),
            const SizedBox(height: 8),
            Container(
              height: 200,
              width: double.infinity,
              clipBehavior:
                  Clip.hardEdge, // 👈 important pour couper le débordement
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10,
                ), // si tu veux des coins arrondis
              ),
              child: Center(
                child: SizedBox.expand(
                  // 👈 force la carte à prendre toute la place dispo sans déborder
                  child: U.OpenStreetMap(
                    center: [long, lat],
                    type: OpenStreetMapType.HOT,
                    zoom: 15,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextButton.icon(
                icon: Icon(Icons.location_on_outlined),
                onPressed: () => getLocationUser(),
                label: Text("Addresse de ma position"),
              ),
            ),

            TextField(
              controller: addresseController,

              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.send),
                label: const Text("Envoyer"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 14,
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void takePicture(ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: source);
    if (xFile != null) {
      setState(() {
        imagefile = File(xFile.path);
        imagePath = xFile.path;
      });
    }
  }

  getLocationUser() async {
    final addr = await LocationService().getAddresseFromCoordinates();
    LocationData? position = await LocationService().getLocationUser();
    if (addr == null || position == null) return;

    setState(() {
      addresseController.text = addr;
      long = position.longitude!;
      lat = position.latitude!;
    });
    print("l'addresse est : $addr");
  }
}
