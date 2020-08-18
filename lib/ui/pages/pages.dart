import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:android_intent/android_intent.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;


import '../../model/models.dart';
import '../../bloc/blocs.dart';
import '../../cubit/cubit.dart';
import '../../services/services.dart';
import '../../shared/shared.dart';
import '../../ui/widgets/widgets.dart';

part 'signIn_signUp_main.dart';
part 'splash_page.dart';
part 'wrapper.dart';
part 'home.dart';
part 'radar.dart';
part 'pin_map.dart';
part 'home_wrapper.dart';
part 'detail_dagang.dart';
part 'profil.dart';
part 'tambah_dagang.dart';
part 'route_map.dart';
part 'edit_profil.dart';
part 'search_dagang.dart';
part 'splash_screen.dart';