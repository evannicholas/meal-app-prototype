import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototype/services/services.dart';
import 'package:prototype/widgets/widgets.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import '../models/models.dart';

part 'home.dart';
part 'login.dart';
part 'register.dart';
part 'meal_details.dart';
part 'edit_profile.dart';
part 'search.dart';
part 'cart.dart';
part 'selectLocation.dart';